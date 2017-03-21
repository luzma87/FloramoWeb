require_relative '../domains/color'

class ColorRepository
  def initialize(connection)
    @db = connection[:color]
  end

  def find_all
    results = @db.order(:nombre)
    colores = []
    results.each do |row|
      colores.push(Color.new(row))
    end
    colores
  end
end
