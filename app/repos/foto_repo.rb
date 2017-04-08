require_relative '../domains/foto'

class FotoRepository
  def initialize(connection)
    @db = connection[:foto]
  end

  def find_by_especie(especie_id)
    results = @db.where(especie_id: especie_id)
    fotos = []
    results.each do |row|
      fotos.push(Foto.new(row))
    end
    fotos
  end

  def save(foto)
    @db.filter('id = ?', foto.id).update(foto.to_save)
    foto
  end

  def insert(foto)
    @db.insert(foto.to_save)
    foto
  end
end
