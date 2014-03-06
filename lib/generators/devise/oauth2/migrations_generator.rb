module Devise
  module Oauth2

    class MigrationsGenerator < Rails::Generators::Base

      Devise::Oauth2::MigrationsGenerator.source_root(File.expand_path './')

      def create_migrations

        copy_file 'db/migrate/20111014160714_create_devise_oauth2_providable_schema.rb', 'db/migrate/20140306063000_create_devise_oauth2_providable_schema.rb'

      end

    end
  end
end
