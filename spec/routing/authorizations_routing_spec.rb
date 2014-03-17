require 'spec_helper'

describe Devise::Oauth2::AuthorizationsController do
  describe 'routing' do
    pending 'routes POST /oauth/authorizations' do
      post('/oauth/authorizations').should route_to('devise/oauth2_providable/authorizations#create')
    end
    pending 'routes GET /oauth/authorize' do
      get('/oauth/authorize').should route_to('devise/oauth2_providable/authorizations#new')
    end
    pending 'routes POST /oauth2/authorize' do
      #FIXME: this is valid, but the route is not being loaded into the test
      post('/oauth2/authorize').should route_to('devise/oauth2_providable/authorizations#new')
    end
  end
end
