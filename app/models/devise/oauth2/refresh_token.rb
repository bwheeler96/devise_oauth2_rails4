class Devise::Oauth2::RefreshToken < ActiveRecord::Base
  expires_according_to :refresh_token_expires_in

  # Deprecated
  #attr_accessible :access_tokens

  has_many :access_tokens

end
