module Devise
  module Oauth2
    class UpgradeGenerator < Rails::Generators::Base

      Devise::Oauth2::UpgradeGenerator.source_root(File.expand_path '../../../../../', __FILE__)

      def upgrade
        copy_file 'db/migrate/20140307013534_devise_oauth2_upgrade_to_version2.rb', 'db/migrate/20140307013534_devise_oauth2_upgrade_to_version2.rb'
      end

    end
  end
end