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
        @access_token ||= AccessToken.find_by(token: access_token) if access_token?
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
        params[:client_id] if params[:client_id]
      end

      def client_id?
        !!client_id
      end

      def auth_code
        params[:code]
      end

      def code?
        !!auth_code
      end

      def refresh_token
        params[:refresh_token] if params[:refresh_token]
      end

      def refresh_token?
        !!refresh_token
      end

      def access_token
        return params[:access_token] if params[:access_token]
        request.headers['HTTP_AUTHORIZATION'].split(' ')[-1] if request.headers['HTTP_AUTHORIZATION']
      end

      def access_token?
        !!access_token
      end

      def authenticate_anyone!
        render json: { error: 'Valid user credentials must be submitted with this request.' }, status: 401 unless current_anything || params[:refresh_token] || params[:code]
      end

      def devise_scope_name
        Rails.application.config.devise_oauth2_rails4.devise_scope
      end

      define_method "current_#{Rails.application.config.devise_oauth2_rails4.devise_scope}" do
        return super() if super()
        return send current_access_token.owner if current_access_token
      end

      def current_anything
        send "current_#{devise_scope_name}"
      end

    end
  end
end
