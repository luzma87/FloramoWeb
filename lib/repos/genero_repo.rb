require_relative '../domains/genero'

class GeneroRepository
  def initialize(connection)
    @db = connection[:genero]
  end

  def find_all
    results = @db.order(:nombre)
    familias = []
    results.each do |row|
      familias.push(Genero.new(row))
    end
    familias
  end
end
