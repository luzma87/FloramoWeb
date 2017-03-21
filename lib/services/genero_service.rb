require_relative '../repos/genero_repo'

class GeneroService
  def initialize(connection)
    @repo = GeneroRepository.new(connection)
  end

  def find_all_for_autocomplete
    generos = @repo.find_all.map { |g| g.nombre }
    json = '{'
    generos.each do |genero|
      json += "'#{genero}': null,"
    end
    json += '}'
  end
end
