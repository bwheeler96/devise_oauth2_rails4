module Devise
  module Oauth2
    class TokensController < ApplicationController

      before_action :authenticate_anyone!
      skip_before_action :verify_authenticity_token, :only => :create

      def create
        @refresh_token = oauth2_current_refresh_token || oauth2_current_client.refresh_tokens.create!(:owner => current_anything)
        @access_token = @refresh_token.access_tokens.create!(:client => oauth2_current_client, :owner => current_anything)
        render :json => @access_token.token_response
      end

      private

      def oauth2_current_client
       env[Devise::Oauth2::CLIENT_ENV_REF]
      end
      def oauth2_current_refresh_token
        env[Devise::Oauth2::REFRESH_TOKEN_ENV_REF]
      end

    end
  end
end
