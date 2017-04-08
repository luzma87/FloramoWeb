require_relative '../repos/familia_repo'
require_relative 'lists_service'

class FamiliaService
  def initialize(connection)
    @repo = FamiliaRepository.new(connection)
  end

  def find_all_for_autocomplete
    familias = @repo.find_all.map(&:nombre)
    ListsService.new.for_autocomplete(familias)
  end

  def find_by_genero_for_autocomplete(name)
    familias = [@repo.find_by_genero(name).nombre]
    ListsService.new.for_autocomplete(familias)
  end

  def java_all_sqls
    lists_service = ListsService.new
    familias = lists_service.java_sqls(@repo.find_all)
    lists_service.sqls_function('Familias', familias)
  end
end
