require_relative '../../floramo_app'

class LoginController < FloramoApp

  get '/', logged_in?: :true do
    # erb :'/login/index', layout: :'layouts/login'
    erb :'/login/index'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  post '/' do
    username = params['user']
    password = params['password']

    if username == '' || password == ''
      status 400
      'Credenciales requeridas'
    else
      # service = UserService.new(mongo_connection)
      # user = service.login(username, password)
      # if user
      #   status 200
      #   session[:user] = user
      #   redirect_for_role
      # else
      #   flash[:danger] = 'Credenciales incorrectas.'
      #   redirect '/login'
      # end
    end
  end
end
