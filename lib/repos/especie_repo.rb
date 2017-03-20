require_relative '../domains/especie'

class EspecieRepository
  def initialize(connection)
    @db = connection[:especie]
  end

  def find_all
    # DB.from(:albums, :artists).where{{artists[:id]=>albums[:artist_id]}}
    # SELECT * FROM albums, artists WHERE artists.id = albums.artist_id
    # DB.fetch("SELECT name FROM users") do |row|
    #   p row[:name]
    # end

    especies = []
    result = @db.order(:nombre)
    result.each { |row| especies.push(Especie.new(row)) }
    especies
  end
end
