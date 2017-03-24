require_relative '../domains/especie'
require_relative '../repos/especie_repo'
require_relative '../repos/foto_repo'
require_relative '../repos/familia_repo'
require_relative '../repos/genero_repo'

class EspecieService
  def initialize(connection)
    @repo = EspecieRepository.new(connection)
    @foto_repo = FotoRepository.new(connection)
    @familia_repo = FamiliaRepository.new(connection)
    @genero_repo = GeneroRepository.new(connection)
  end

  def find_by_nombre_cientifico(nombre_cientifico)
    genero, *especie = nombre_cientifico.split(/_/)
    especie = @repo.find_by_genero_and_especie(genero, especie.join(' '))
    especie.fotos = @foto_repo.find_by_especie(especie.id)
    especie
  end

  def save(params_especie)
    familia_nombre = params_especie[:familia_nombre]
    genero_nombre = params_especie[:genero_nombre]

    familia = @familia_repo.find_by_name(familia_nombre)
    genero = @genero_repo.find_by_name(genero_nombre)

    params_especie[:genero] = genero

    familias_equal = familia == genero.familia
    return false unless familias_equal
    especie = Especie.new(params_especie)
    @repo.save(especie)
  end

end
