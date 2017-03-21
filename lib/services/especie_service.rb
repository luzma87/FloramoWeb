require_relative '../domains/especie'
require_relative '../repos/especie_repo'
require_relative '../repos/foto_repo'

class EspecieService
  def initialize(connection)
    @repo = EspecieRepository.new(connection)
    @foto_repo = FotoRepository.new(connection)
  end

  def find_by_nombre_cientifico(nombre_cientifico)
    genero, *especie = nombre_cientifico.split(/_/)
    especie = @repo.find_by_genero_and_especie(genero, especie.join(' '))
    especie.fotos = @foto_repo.find_by_especie(especie.id)
    especie
  end

  def login(username, password)
    user = @repo.find_one_by_username(username)
    return unless user
    user_encrypted_pass = BCrypt::Password.new(user.password)
    user if user_encrypted_pass == password
  end
end
