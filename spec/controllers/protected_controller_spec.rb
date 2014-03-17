require 'spec_helper'

describe ProtectedController do

  describe 'get :index' do
    with :client
    with :user
    before do
      @token = Devise::Oauth2::AccessToken.create! :client => client, :owner => user
    end
    context 'with valid bearer token in header' do
      before do
        @request.env['HTTP_AUTHORIZATION'] = "Bearer #{@token.token}"
        get :index, :format => 'json'
      end
      it { should respond_with :ok }
    end
    context 'with valid bearer token in query string' do
      before do
        get :index, :access_token => @token.token, :format => 'json'
      end
      it { should respond_with :ok }
    end

    context 'with invalid bearer token in query param' do
      before do
        get :index, :access_token => 'invalid', :format => 'json'
      end
      it { should respond_with :unauthorized }
    end
  end
end
