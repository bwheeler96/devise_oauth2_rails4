class Devise::Oauth2::Client < ActiveRecord::Base

  has_many :access_tokens
  has_many :refresh_tokens
  has_many :authorization_codes

  belongs_to :owner, polymorphic: true

  before_validation :init_identifier, :on => :create, :unless => :identifier?
  before_validation :init_secret, :on => :create, :unless => :secret?
  validates :identifier, :presence => true, :uniqueness => true

  serialize :default_permissions

  def default_permissions=(permissions)
    super(permissions) if permissions.is_a? Array
    permissions = permissions.split(/[,\s\n\b\t]/).keep_if { |x| !x.blank? } if permissions.is_a? String
    super(permissions)
  end

  private

  def init_identifier
    self.identifier = Devise::Oauth2.random_id
  end

  def init_secret
    self.secret = Devise::Oauth2.random_id
  end

end
