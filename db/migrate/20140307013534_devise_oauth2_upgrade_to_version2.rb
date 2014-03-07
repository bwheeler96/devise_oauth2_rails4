class DeviseOauth2UpgradeToVersion2 < ActiveRecord::Migration
  def change

    change_table :oauth2_clients do |t|
			t.text :default_permissions
      t.belongs_to :owner, polymorphic: true
      t.index :owner_id
    end

    change_table :oauth2_access_tokens do |t|
			t.text :permissions
      t.rename :user_id, :owner_id
      t.string :owner_type
    end

    change_table :oauth2_refresh_tokens do |t|
      t.rename :user_id, :owner_id
      t.string :owner_type
    end

    change_table :oauth2_authorization_codes do |t|
      t.rename :user_id, :owner_id
      t.string :owner_type
    end

    Devise::Oauth2::AuthorizationCode.update_all("owner_type = 'User'")
    Devise::Oauth2::Client.update_all("owner_type = 'User'")
    Devise::Oauth2::AccessToken.update_all("owner_type = 'User'")
    Devise::Oauth2::RefreshToken.update_all("owner_type = 'User'")

  end
end
