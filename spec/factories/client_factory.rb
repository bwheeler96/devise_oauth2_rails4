FactoryGirl.define do
  factory :client, :class => 'Devise::Oauth2::Client' do
    name 'test'
    website 'http://localhost'
    redirect_uri 'http://localhost:3000'
  end
end
