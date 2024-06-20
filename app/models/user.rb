class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  validates :pseudo, presence: true, uniqueness: true

  has_many :arena_players
  has_many :arenas, through: :arena_players

  def self.from_omniauth(access_token)
    user_data = access_token.info
    user_email = fetch_primary_email(access_token.credentials.token)

    user = User.where(email: user_email).first

    unless user
      user = User.create(
        email: user_email,
        password: Devise.friendly_token[0, 20],
        pseudo: user_data['nickname'],
        avatar_url: user_data['image']
      )
    end
    user
  end

  private

  def self.fetch_primary_email(access_token)
    emails_url = 'https://api.github.com/user/emails'
    response = RestClient.get(emails_url, { Authorization: "token #{access_token}" })
    emails = JSON.parse(response.body)

    primary_email = emails.find { |email| email['primary'] && email['verified'] }
    primary_email ? primary_email['email'] : nil
  rescue StandardError => e
    Rails.logger.error "Failed to fetch primary email from GitHub: #{e.message}"
    nil
  end
end
