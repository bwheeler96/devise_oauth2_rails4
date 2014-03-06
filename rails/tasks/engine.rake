
namespace :devise do
  namespace :oauth2 do

    task :install_migrations do

      Dir.mkdir("db") unless Dir.exists?("db")
      unless File.exists?("db/my.db")
        File.open("db/my.db", 'w') do |f|
          f.write("Hello db")
        end
      end

    end

  end
end