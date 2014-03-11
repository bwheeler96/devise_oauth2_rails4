class ApplicationController < ActionController::Base
  protect_from_forgery

  include Devise::Oauth2::Authorization

  def before_authorize
    Rails.logger.info current_oauth2_client
  end

  def after_authorize
    Rails.logger.info 'We are calling after authorize!!!'
  end

  def after_denied_authorization
    redirect_to '/'
  end

end
