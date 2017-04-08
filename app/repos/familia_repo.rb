require_relative '../domains/familia'

class FamiliaRepository
  def initialize(connection)
    @connection = connection
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

  def find_since(date)
    results = @db.where { "modified_date >= '#{date}'" }.order(:nombre)
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

  def find_by_genero(name)
    sql = "SELECT id, nombre FROM familia
            WHERE id = (SELECT familia_id FROM genero WHERE nombre = '#{name}')"
    familias = []
    @connection.fetch(sql) do |row|
      familias.push(Familia.new(row))
    end
    p "especie_repo.find_by_genero_and_especie has #{familias.size} results!!!" if familias.size > 1
    familias.first
  end
end
