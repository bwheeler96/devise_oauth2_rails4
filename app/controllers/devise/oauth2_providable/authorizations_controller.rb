module Devise
  module Oauth2Providable
    class AuthorizationsController < ApplicationController

      before_action :authenticate_user!

      rescue_from Rack::OAuth2::Server::Authorize::BadRequest do |e|
        @error = e
        render :error, :status => e.status
      end

      def new
        authorize_endpoint
      end

      def create
        authorize_endpoint(:allow_approval)
      end

      private

      def respond(status, header, response)
        ["WWW-Authenticate"].each do |key|
          headers[key] = header[key] if header[key].present?
        end
        if response.redirect?
          redirect_to header['Location']
        else
          render :new
        end
      end

      def authorize_endpoint(allow_approval = false)
        authorization = Rack::OAuth2::Server::Authorize.new do |req, res|
          @client = Client.find_by_identifier(req.client_id) || req.bad_request!

          if @client
            res.redirect_uri = @redirect_uri = req.verify_redirect_uri!(@client.redirect_uri)

            if allow_approval || @client.passthrough?
              if params[:approve].present? || @client.passthrough?
                case req.response_type
                  when :code
                    authorization_code = current_user.authorization_codes.create!(:client => @client)
                    res.code = authorization_code.token
                  when :token
                    access_token = current_user.access_tokens.create!(:client => @client).token
                    bearer_token = Rack::OAuth2::AccessToken::Bearer.new(:access_token => access_token)
                    res.access_token = bearer_token
                    # res.uid = current_user.id
                end
                res.approve!
              else
                req.access_denied!
              end
            else
              @response_type = req.response_type
            end
          end
        end

        respond *authorization.call(request.env)
      end

    end
  end
end
