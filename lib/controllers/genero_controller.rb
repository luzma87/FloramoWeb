require_relative '../../floramo_app'
require_relative '../services/genero_service'
require_relative 'connection_helper'

class GeneroController < FloramoApp
  include ConnectionHelper

  get '/familia/:familia_nombre', auth: :admin do
    service = GeneroService.new(pg_connection)
    service.find_by_familia_for_autocomplete(params[:familia_nombre])
  end

end
