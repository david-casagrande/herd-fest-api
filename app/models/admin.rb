class Admin < ApplicationRecord
  devise :trackable, :timeoutable, :validatable
  devise :database_authenticatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    Admin.find_by(email: data['email']) || nil
  end
end
