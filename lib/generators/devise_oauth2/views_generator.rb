class ViewsGenerator < Rails::Generators::Base
	
	File.open(File.expand_path('../../../../app/views/devise_outh/authorize.html.haml', __FILE__), 'w+') do f
		f << 'helo'
	end

end
