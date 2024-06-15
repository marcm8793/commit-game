class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :pseudo, presence: true, uniqueness: true

  devise :omniauthable, omniauth_providers: [:github]

  has_many :arena_players
  has_many :arenas, through: :arena_players

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    Rails.logger.info("Omniauth access token info: #{data.inspect}")

    # unless email.present?
    #   Rails.logger.error("Email is missing in the omniauth data: #{data.inspect}")
    #   return nil
    # end

        Rails.logger.info("Omniauth access token info: #{data.inspect}")

        # user = User.where(email: email).first
        # Rails.logger.info("User from omniauth: #{user.inspect}")

    # Uncomment the section below if you want users to be created if they don't exist
     unless user
        user = User.create(
           email: data.email,
           password: Devise.friendly_token[0,20],
           pseudo: data['nickname'],
           avatar_url: data['image']
        )
    end
    user
  end

end
