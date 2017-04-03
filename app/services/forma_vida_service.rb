require_relative '../repos/forma_vida_repo'
require_relative 'lists_service'

class FormaVidaService
  def initialize(connection)
    @repo = FormaVidaRepository.new(connection)
  end

  def java_sqls
    formas_vida = @repo.find_all
    ListsService.new.java_sqls(formas_vida)
  end
end
