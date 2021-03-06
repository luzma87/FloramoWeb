require_relative '../../floramo_app'
require_relative 'connection_helper'
require_relative '../domains/user'
require_relative '../services/user_service'

class UserController < FloramoApp
  include ConnectionHelper

  get '/', auth: :admin do
    repo = UserRepository.new(pg_connection)
    users = repo.find_all

    erb :'/user/index', locals: { users: users }
  end

  get '/create', auth: :admin do
    erb :'/user/create', locals: { user: User.new({}) }
  end

  get '/password/:username', auth: :user do
    repo = UserRepository.new(pg_connection)
    user = repo.find_by_username(params[:username])
    erb :'/user/password', locals: { user: user }
  end

  post '/create', auth: :admin do
    service = UserService.new(pg_connection)
    saved = service.create(params)
    flash[:warning] = 'ERROR' unless saved
    flash[:success] = 'OK'
    redirect '/users'
  end

  post '/save', auth: :admin do
    service = UserService.new(pg_connection)
    saved = service.save(params)
    flash[:warning] = 'ERROR' unless saved
    flash[:success] = 'OK'
    redirect '/users'
  end

  post '/password', auth: :user do
    service = UserService.new(pg_connection)
    saved = service.update_password(params)
    unless saved
      flash[:warning] = 'ERROR' unless saved
      halt(500, erb(:'/error/500', locals: { error: '' }))
    end
    flash[:success] = 'OK'
    redirect_for_role
  end

  post '/delete', auth: :admin do
    repo = UserRepository.new(pg_connection)
    if repo.find_all.size == 1
      flash[:warning] = "Can't delete last user"
      redirect '/users'
    end
    user = User.new(params)
    repo.delete(user)
    flash[:success] = 'OK'
    redirect '/users'
  end
end
