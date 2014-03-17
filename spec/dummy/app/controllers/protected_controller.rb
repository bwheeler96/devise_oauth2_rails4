class ProtectedController < ApplicationController

  #before_action "authenticate_#{Rails.application.config.devise_oauth2_rails4.devise_scope}!"

  def index
    render :nothing => true, :status => :ok if current_oauth2_client
    render nothing: true, status: 401 unless current_oauth2_client
  end

end
