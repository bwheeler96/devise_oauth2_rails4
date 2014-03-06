class CreateDeviseOauth2ProvidableSchema < ActiveRecord::Migration
  def change
    create_table :oauth2_clients do |t|
      t.belongs_to :owner, polymorphic: true
      t.text :default_permissions
      t.string :redirect_uri
      t.string :identifier
      t.string :secret
      t.boolean :passthrough, default: false, null: false
      t.timestamps
    end
    change_table :oauth2_clients do |t|
      t.index :identifier, :unique => true
    end

    create_table :oauth2_access_tokens do |t|
      t.belongs_to :owner, polymorphic: true
      t.text :permissions
      t.integer :client_id
      t.integer :refresh_token_id
      t.string :token
      t.datetime :expires_at
      t.timestamps
    end
    change_table :oauth2_access_tokens do |t|
      t.index :token, :unique => true
      t.index :expires_at
      t.index :owner_id
      t.index :client_id
    end

    create_table :oauth2_refresh_tokens do |t|
      t.belongs_to :owner, polymorphic: true
      t.belongs_to :client
      t.string :token
      t.datetime :expires_at
      t.timestamps
    end
    change_table :oauth2_refresh_tokens do |t|
      t.index :token, :unique => true
      t.index :expires_at
      t.index :owner_id
      t.index :client_id
    end

    create_table :oauth2_authorization_codes do |t|
      t.belongs_to :owner, polymorphic: true
      t.belongs_to :client
      t.string :token
      t.datetime :expires_at
      t.timestamps
    end
    change_table :oauth2_authorization_codes do |t|
      t.index :token, :unique => true
      t.index :expires_at
      t.index :owner_id
      t.index :client_id
    end
  end
end
