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
    familias = lists_service.java_insert_sqls(@repo.find_all)
    lists_service.sqls_function('Familias', familias)
  end

  def java_sqls_since(date)
    lists_service = ListsService.new
    familias = @repo.find_since(date)
    sqls = lists_service.java_delete_sqls(familias, 'familia')
    sqls + lists_service.java_insert_sqls(familias)
  end
end
