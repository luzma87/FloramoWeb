require_relative '../../floramo_app'
require_relative '../repos/especie_repo'
require_relative '../repos/color_repo'
require_relative '../repos/forma_vida_repo'
require_relative '../services/especie_service'
require_relative '../services/familia_service'
require_relative '../services/genero_service'
require_relative 'connection_helper'

class EspecieController < FloramoApp
  include ConnectionHelper

  get '/', auth: :admin do
    repo = EspecieRepository.new(pg_connection)
    especies = repo.find_all

    erb :'/especie/index', locals: { especies: especies }
  end

  get '/:nombre_cientifico', auth: :admin do
    nombre_cientifico = params[:nombre_cientifico]

    service = EspecieService.new(pg_connection)
    familia_service = FamiliaService.new(pg_connection)
    genero_service = GeneroService.new(pg_connection)
    especie = service.find_by_nombre_cientifico(nombre_cientifico)
    color_repo = ColorRepository.new(pg_connection)
    forma_vida_repo = FormaVidaRepository.new(pg_connection)

    erb :'/especie/show', locals: {
      especie: especie,
      colores: color_repo.find_all,
      formas_vida: forma_vida_repo.find_all,
      familias: familia_service.find_all_for_autocomplete,
      generos: genero_service.find_all_for_autocomplete
    }
  end

  post '/save' do
    p '------------------------------------------------------'
    p params
    p '------------------------------------------------------'
    # redirect '/especie'
  end
end
