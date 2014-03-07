module PermissionsHelper

  def requested_permissions
    params[:permissions] || @client.default_permissions
  end

end