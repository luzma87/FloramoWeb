require_relative '../repos/forma_vida_repo'
require_relative 'lists_service'

class FormaVidaService
  def initialize(connection)
    @repo = FormaVidaRepository.new(connection)
  end

  def java_all_sqls
    lists_service = ListsService.new
    formas_vida = lists_service.java_insert_sqls(@repo.find_all)
    lists_service.sqls_function('FormasVida', formas_vida)
  end
end
