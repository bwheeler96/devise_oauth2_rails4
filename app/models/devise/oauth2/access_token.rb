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

  def method_missing(method, *args, &block)
    if method.to_s.match /^can_.*\?$/
      permission = method.to_s.match(/^can_(.*)\?$/)[1]
      return true if permission.in? self.permissions
      return false
    end
    super(method, *args, &block)
  end

  private

  def restrict_expires_at
    self.expires_at = [self.expires_at, refresh_token.expires_at].compact.min
  end
end
