require_relative '../repos/familia_repo'

class FamiliaService
  def initialize(connection)
    @repo = FamiliaRepository.new(connection)
  end

  def find_all_for_autocomplete
    familias = @repo.find_all.map { |f| f.nombre }
    json = '{'
    familias.each do |familia|
      json += "'#{familia}': null,"
    end
    json += '}'
  end
end
