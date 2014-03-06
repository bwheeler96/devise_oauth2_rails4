module Devise
  module Oauth2
    class ViewsGenerator < Rails::Generators::Base

      File.open(File.expand_path('../../../../../app/views/devise/oauth2/authorize.html.haml', __FILE__), 'w+') do |f|
        f << 'helo'
      end

    end
  end
end
