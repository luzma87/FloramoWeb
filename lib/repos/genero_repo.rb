require_relative '../domains/genero'

class GeneroRepository
  def initialize(connection)
    @connection = connection
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

  def find_by_name(name)
    sql = "select g.id, g.nombre, f.id familia_id, f.nombre familia from genero g
          inner join familia f on g.familia_id = f.id
          where g.nombre = '#{name}'"
    generos = []
    @connection.fetch(sql) do |row|
      generos.push(genero(row))
    end
    p "genero_repo.find_by_name has #{generos.size} results!!!" if generos.size > 1
    generos.first
  end

  private

  def genero(row)
    row[:familia] = familia(row)
    Genero.new(row)
  end

  def familia(row)
    Familia.new(id: row[:familia_id], nombre: row[:familia])
  end
end
