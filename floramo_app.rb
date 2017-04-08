require 'sinatra'
require 'rack-flash'
require 'json/ext'

require_relative 'config/config'

class FloramoApp < Sinatra::Application
  helpers Sinatra::Helpers

  config_file('config/config.yml.erb')

  configure { set :server, :puma }

  set :session_secret, ENV.fetch('SESSION_SECRET')
  # set :session_secret, 'BJYQOxqWDiR8J9DlIvFARfPjLfOXRe9J'
  use Rack::Session::Cookie,
      key: '_rack_session',
      path: '/',
      expire_after: 7_200,
      secret: settings.session_secret
  use Rack::Flash, sweep: true

  # set folder for templates to ../views, but make the path absolute
  set :views, File.expand_path('../app/views', __FILE__)
  set :erb, layout: :'layouts/layout'

  # don't enable logging when running tests
  configure :production, :development do
    enable :logging
  end

  register do
    def auth(type)
      condition do
        if !user?
          redirect '/login'
        else
          redirect '/error/403' unless send("#{type}?")
        end
      end
    end

    def logged_in?(_)
      condition do
        redirect_for_role
      end
    end
  end

  helpers do
    def user?
      !@user.nil?
    end

    def editor?
      !@user.nil? && (@user.admin? || @user.editor?)
    end

    def admin?
      !@user.nil? && @user.admin?
    end
  end

  before do
    @user = session[:user]
  end

  get '/', auth: :user do
    redirect_for_role
  end

  protected

  def redirect_for_role
    @user = session[:user]
    redirect '/especies' if admin?
    redirect '/especies' if user?
    redirect '/especies' if editor?
  end
end
