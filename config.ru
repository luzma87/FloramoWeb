require 'sinatra/base'

# pull in the helpers and controllers
Dir.glob('./app/{helpers,controllers,api}/*.rb').each { |file| require file }

not_found do
  erb :'/error/404', layout: :'layouts/login'
end

# map the controllers to routes
map('/') { run FloramoApp }
map('/login') { run LoginController }

map('/especies') { run EspecieController }
map('/generos') { run GeneroController }
map('/migraciones') { run MigracionController }
map('/users') { run UserController }

map('/error') { run ErrorController }
