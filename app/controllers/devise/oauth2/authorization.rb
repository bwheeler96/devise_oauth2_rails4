module Devise
  module Oauth2
    module Authorization
      extend ActiveSupport::Concern

      def current_oauth2_client(opts: { secure: false })
        return @secure_client ||= Client.find_by(secret: client_secret) if opts[:secure]
        return @secure_client ||= Client.find_by(id: current_access_token.client_id) if valid_access_token?
        @client ||= Client.find_by('identifier = :client_id OR secret = :secret', client_id: client_id, secret: client_secret) if client_credentials?
      end

      def current_access_token
        @access_token ||= AccessToken.find_by(token: access_token) if accesss_token?
      end

			def valid_access_token?
				!!current_access_token
			end

      def oauth2_client_signed_in?
        !!@client
      end

      def access_token_signed_in?
        !!@access_token
      end

      def client_credentials
        client_id? || client_secret?
      end

      def client_credentials?
        !!client_credentials
      end

      def client_secret
        params[:client_secret]
      end

      def client_secret?
        !!client_secret
      end

      def client_id
        params[:client_id]
      end

      def client_id?
        !!params[:client_id]
      end

      def access_token
        params[:access_token]
      end

      def access_token?
        !!access_token
      end

    end
  end
end
