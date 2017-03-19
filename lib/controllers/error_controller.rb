require_relative '../../floramo_app'

class ErrorController < FloramoApp
  get '/403' do
    status 403
    erb :'/error/403'
  end
end
