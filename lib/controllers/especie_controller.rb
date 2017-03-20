require_relative '../../floramo_app'
require_relative '../repos/especie_repo'
require_relative 'connection_helper'

class EspecieController < FloramoApp
  include ConnectionHelper

  get '/', auth: :admin do
    repo = EspecieRepository.new(pg_connection)
    especies = repo.find_all

    erb :'/especie/index', locals: { especies: especies }
  end
end