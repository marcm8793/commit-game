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
    Rails.logger.info "Starting OAuth authentication process"
    user_data = access_token.info
    Rails.logger.info "User data from OAuth: #{user_data.inspect}"

    user_email = fetch_primary_email(access_token.credentials.token)
    Rails.logger.info "Fetched primary email: #{user_email}"

    # If we couldn't get the email, use the one provided by OmniAuth
    user_email ||= user_data['email']
    Rails.logger.info "Using email from OmniAuth if primary not found: #{user_email}"

    # If we still don't have an email, generate a temporary one
    user_email ||= "#{user_data['nickname']}@example.com"
    Rails.logger.info "Final email being used: #{user_email}"

    user = User.find_by(email: user_email)
    Rails.logger.info user ? "Existing user found" : "No existing user found"

    unless user
      Rails.logger.info "Creating new user"
      user = User.create(
        email: user_email,
        password: Devise.friendly_token[0, 20],
        pseudo: user_data['nickname'],
        avatar_url: user_data['image']
      )
      Rails.logger.info user.persisted? ? "User created successfully" : "Failed to create user: #{user.errors.full_messages}"
    end

    Rails.logger.info "Returning user: #{user.inspect}"
    user
  end

  private

  def self.fetch_primary_email(access_token)
    Rails.logger.info "Fetching primary email from GitHub"
    emails_url = 'https://api.github.com/user/emails'
    response = RestClient.get(emails_url, { Authorization: "token #{access_token}" })
    emails = JSON.parse(response.body)
    Rails.logger.info "Fetched emails: #{emails.inspect}"

    primary_email = emails.find { |email| email['primary'] && email['verified'] }
    result = primary_email ? primary_email['email'] : nil
    Rails.logger.info "Primary email found: #{result}"
    result
  rescue StandardError => e
    Rails.logger.error "Failed to fetch primary email from GitHub: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    nil
  end
end
