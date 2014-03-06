require 'devise/models'

module Devise
  module Models
    module OAuth2
      extend ActiveSupport::Concern
      included do
        has_many :access_tokens, :class_name => 'Devise::OAuth2::AccessToken'
        has_many :authorization_codes, :class_name => 'Devise::OAuth2::AuthorizationCode'
      end
    end
  end
end
