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
end
