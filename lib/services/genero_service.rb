require_relative '../repos/genero_repo'
require_relative 'autocomplete_service'

class GeneroService
  def initialize(connection)
    @repo = GeneroRepository.new(connection)
  end

  def find_all_for_autocomplete
    generos = @repo.find_all.map(&:nombre)
    AutocompleteService.new.for_autocomplete(generos)
  end

  def find_by_familia_for_autocomplete(name)
    generos = @repo.find_by_familia(name).map(&:nombre)
    AutocompleteService.new.for_autocomplete(generos)
  end
end
