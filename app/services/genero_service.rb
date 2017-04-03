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

  def java_sqls
    generos = @repo.find_all
    ListsService.new.java_sqls(generos)
  end
end
