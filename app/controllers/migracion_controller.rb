require_relative '../../floramo_app'
require_relative '../services/migracion_service'
require_relative 'connection_helper'

class MigracionController < FloramoApp
  include ConnectionHelper

  get '/all', auth: :admin do
    service = MigracionService.new(pg_connection)
    sql = service.all_sqls
    erb :'/migracion/index', locals: { title: 'Todos los datos', sql: sql }
  end

  get '/new', auth: :admin do
    erb :'/migracion/new'
  end

  get '/', auth: :admin do
    service = MigracionService.new(pg_connection)
    sql = service.all_sqls
    erb :'/migracion/index', locals: { sql: sql }
  end

  get '/new_sqls', auth: :admin do
    service = MigracionService.new(pg_connection)
    flags = {}
    flags[:with_fotos] = params[:fotos] == 'on'
    flags[:with_description] = params[:con_descripcion] == 'on'
    flags[:only_description] = params[:solo_descripcion] == 'on'
    selected_date = params[:date]
    sql = ''
    sql = service.sqls_since(selected_date, flags) unless selected_date == ''
    erb :'/migracion/index', locals: { title: "Actualizados desde #{selected_date}", sql: sql }
  end
end
