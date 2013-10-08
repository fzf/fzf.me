require 'rubygems'
require 'compass' #must be loaded before sinatra
require 'sinatra'
require 'sinatra/twitter-bootstrap'
require 'haml'    #must be loaded after sinatra


# set sinatra's variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, "views"
set :public_dir, 'static'
set :fonts_dir, 'fonts'
set :images_dir, 'images'

configure do
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.config'))
  register Sinatra::Twitter::Bootstrap::Assets
end


# at a minimum, the main sass file must reside within the ./views directory. here, we create a ./views/stylesheets directory where all of the sass files can safely reside.
get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass(:"stylesheets/#{params[:name]}", Compass.sass_engine_options )
end

get '/' do
  haml :index
end

helpers do
  def img(name)
    "<img src='images/#{name}' alt='#{name}' />"
  end

  def link_to(url,text=url,opts={})
    attributes = ""
    opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
    "<a href=\"#{url}\" #{attributes}>#{text}</a>"
  end
end