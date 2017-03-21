require_relative '../../floramo_app'
require_relative '../repos/especie_repo'
require_relative '../repos/color_repo'
require_relative '../services/especie_service'
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
    especie = service.find_by_nombre_cientifico(nombre_cientifico)
    color_repo = ColorRepository.new(pg_connection)

    p '..................'
    p especie
    p '..................'

    erb :'/especie/show', locals: { especie: especie, colores: color_repo.find_all }
  end
end
