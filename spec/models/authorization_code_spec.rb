require 'spec_helper'

describe Devise::Oauth2::AuthorizationCode do
  describe 'basic authorization code instance' do
    with :client
    with :user
    subject do
      Devise::Oauth2::AuthorizationCode.create! :client => client, owner: user
    end
    it { should validate_presence_of :token }
    it { should validate_uniqueness_of :token }
    it { should belong_to :owner }
    it { should belong_to :client }
    it { should validate_presence_of :client }
    it { should validate_presence_of :expires_at }
    it { should have_db_index :client_id }
    it { should have_db_index :owner_id }
    it { should have_db_index(:token).unique(true) }
    it { should have_db_index :expires_at }
  end
end

