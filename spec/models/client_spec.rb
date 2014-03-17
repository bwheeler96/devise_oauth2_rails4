require 'spec_helper'

describe Devise::Oauth2::Client do
  it { Devise::Oauth2::Client.table_name.should == 'oauth2_clients' }

  describe 'basic client instance' do
    with :client
    subject { client }
    it { should validate_uniqueness_of :identifier }
    it { should have_db_index(:identifier).unique(true) }
    it { should have_many :refresh_tokens }
    it { should have_many :authorization_codes }
  end
end
