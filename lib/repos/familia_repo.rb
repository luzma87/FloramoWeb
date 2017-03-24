require_relative '../domains/familia'

class FamiliaRepository
  def initialize(connection)
    @db = connection[:familia]
  end

  def find_all
    results = @db.order(:nombre)
    familias = []
    results.each do |row|
      familias.push(Familia.new(row))
    end
    familias
  end

  def find_by_name(name)
    results = @db.where(nombre: name)
    Familia.new(results.first)
  end

end
