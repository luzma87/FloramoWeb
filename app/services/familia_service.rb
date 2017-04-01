require_relative '../repos/familia_repo'
require_relative 'autocomplete_service'

class FamiliaService
  def initialize(connection)
    @repo = FamiliaRepository.new(connection)
  end

  def find_all_for_autocomplete
    familias = @repo.find_all.map(&:nombre)
    AutocompleteService.new.for_autocomplete(familias)
  end

  def find_by_genero_for_autocomplete(name)
    familias = [@repo.find_by_genero(name).nombre]
    AutocompleteService.new.for_autocomplete(familias)
  end
end
