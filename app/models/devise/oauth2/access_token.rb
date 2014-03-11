class Devise::Oauth2::AccessToken < ActiveRecord::Base

  expires_according_to :access_token_expires_in
  before_validation :restrict_expires_at, :on => :create, :if => :refresh_token
  belongs_to :refresh_token

  belongs_to :owner, polymorphic: true
  serialize :permissions

  def permissions=(permissions)
    super(permissions) if permissions.is_a? Array
    permissions = permissions.split(/[,\s\n\b\t]/).keep_if { |x| !x.empty? } if permissions.is_a? String
    super(permissions)
  end

  def token_response
    response = {
      :access_token => token,
      :token_type => 'bearer',
      :expires_in => expires_in
    }
    response[:refresh_token] = refresh_token.token if refresh_token
    response
  end

  def can?(do_permission)
    do_permission.to_s.in? Array(self.permissions)
  end

  private

  def restrict_expires_at
    self.expires_at = [self.expires_at, refresh_token.expires_at].compact.min
  end
end
