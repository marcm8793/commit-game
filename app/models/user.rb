class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :pseudo, presence: true, uniqueness: true

  devise :omniauthable, omniauth_providers: [:github]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
     unless user
        user = User.create(
           email: data['email'],
           password: Devise.friendly_token[0,20],
           pseudo: data['nickname'],
           avatar_url: data['image']
        )
    end
    user
end
end
