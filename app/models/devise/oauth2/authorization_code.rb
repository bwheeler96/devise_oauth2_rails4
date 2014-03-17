class Devise::Oauth2::AuthorizationCode < ActiveRecord::Base
  expires_according_to :authorization_code_expires_in
  belongs_to :owner, polymorphic: true
end
