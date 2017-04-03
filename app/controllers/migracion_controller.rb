require_relative '../../floramo_app'
require_relative '../services/migracion_service'
require_relative 'connection_helper'

class MigracionController < FloramoApp
  include ConnectionHelper

  get '/all', auth: :admin do
    service = MigracionService.new(pg_connection)
    sql = service.all_sqls
    erb :'/migracion/index', locals: { sql: sql }
  end

  get '/', auth: :admin do
    service = MigracionService.new(pg_connection)
    sql = service.all_sqls
    erb :'/migracion/index', locals: { sql: sql }
  end
end
