require_relative '../domains/forma_vida'

class FormaVidaRepository
  def initialize(connection)
    @db = connection[:forma_vida]
  end

  def find_all
    results = @db.order(:nombre)
    formas_vida = []
    results.each do |row|
      formas_vida.push(FormaVida.new(row))
    end
    formas_vida
  end
end
