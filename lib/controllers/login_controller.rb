require 'bcrypt'
require_relative '../../floramo_app'
require_relative 'connection_helper'
require_relative '../services/user_service'

class LoginController < FloramoApp
  include ConnectionHelper

  get '/', logged_in?: :true do
    erb :'/login/index', layout: :'layouts/login'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  post '/' do
    username = params['username']
    password = params['password']

    if username == '' || password == ''
      status 400
      'Credenciales requeridas'
    else
      service = UserService.new(pg_connection)
      user = service.login(username, password)
      if user
        status 200
        session[:user] = user
        redirect_for_role
      else
        flash[:danger] = 'Credenciales incorrectas.'
        redirect '/login'
      end
    end
  end
end
