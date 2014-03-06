require 'devise/models'

module Devise
  module Models
    module Oauth2
      extend ActiveSupport::Concern
      included do
        has_many :access_tokens, :class_name => 'Devise::Oauth2::AccessToken', as: :owner
        has_many :authorization_codes, :class_name => 'Devise::Oauth2::AuthorizationCode', as: :owner
      end
    end
  end
end
