require_relative '../repos/genero_repo'
require_relative 'lists_service'

class GeneroService
  def initialize(connection)
    @repo = GeneroRepository.new(connection)
  end

  def find_all_for_autocomplete
    generos = @repo.find_all.map(&:nombre)
    ListsService.new.for_autocomplete(generos)
  end

  def find_by_familia_for_autocomplete(name)
    generos = @repo.find_by_familia(name).map(&:nombre)
    ListsService.new.for_autocomplete(generos)
  end

  def java_all_sqls
    lists_service = ListsService.new
    generos = lists_service.java_sqls(@repo.find_all)
    lists_service.sqls_function('Genero', generos)
  end
end
