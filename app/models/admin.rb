class Admin < ActiveRecord::Base
  devise :trackable, :timeoutable, :validatable
  devise :database_authenticatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    Admin.where(email: data['email']).first || nil
  end
end
