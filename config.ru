require 'sinatra/base'

# pull in the helpers and controllers
Dir.glob('./lib/{helpers,controllers,api}/*.rb').each { |file| require file }

not_found do
  erb :'/error/404', layout: :'layouts/login'
end

# map the controllers to routes
map('/') { run FloramoApp }
map('/login') { run LoginController }

map('/especie') { run EspecieController }

map('/error') { run ErrorController }
