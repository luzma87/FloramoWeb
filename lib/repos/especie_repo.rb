require_relative '../domains/especie'
require_relative '../domains/genero'
require_relative '../domains/familia'
require_relative '../domains/color'
require_relative '../domains/forma_vida'

class EspecieRepository
  def initialize(connection)
    @db = connection
  end

  def find_all
    sql = "#{base_sql} order by genero, nombre"

    especies = []
    @db.fetch(sql) do |row|
      especies.push(especie(row))
    end
    especies
  end

  def find_by_genero_and_especie(genero, especie)
    sql = "#{base_sql} where  e.nombre = '#{especie}' and g.nombre = '#{genero}'"
    especies = []
    @db.fetch(sql) do |row|
      especies.push(especie(row))
    end
    p "there are #{especies.size} results!!!" if especies.size > 1
    especies.first
  end

  private

  # rubocop:disable Metric/MethodLength
  def base_sql
    'select
            e. id,
            g.id genero_id,
            f.id familia_id,
            c1.id color1_id,
            c2.id color2_id,
            v1.id forma_vida1_id,
            v2.id forma_vida2_id,
            e.nombre nombre,
            g.nombre genero,
            f.nombre familia,
            e.id_tropicos,
            c1.nombre color1,
            c2.nombre color2,
            v1.nombre forma_vida1,
            v2.nombre forma_vida2,
            e.descripcion_es,
            e.descripcion_en,
            e.distribucion_es,
            e.distribucion_en,
            e.thumbnail
          from especie e
            left join genero g on e.genero_id = g.id
            left join familia f on g.familia_id = f.id
            left join color c1 on e.color1_id = c1.id
            left join color c2 on e.color2_id = c2.id
            left join forma_vida v1 on e.forma_vida1_id = v1.id
            left join forma_vida v2 on e.forma_vida2_id = v2.id'
  end

  def especie(row)
    familia_new = familia(row)
    row[:familia] = familia_new
    row[:genero] = genero(familia_new, row)
    row[:color1] = color(row, 1)
    row[:color2] = color(row, 2)
    row[:forma_vida1] = forma_vida(row, 1)
    row[:forma_vida2] = forma_vida(row, 2)
    Especie.new(row)
  end

  def genero(familia, row)
    Genero.new(id: row[:genero_id], nombre: row[:genero], familia: familia)
  end

  def familia(row)
    Familia.new(id: row[:familia_id], nombre: row[:familia])
  end

  def color(row, index)
    id = row["color#{index}_id".to_sym]
    nombre = row["color#{index}".to_sym]
    Color.new(id: id, nombre: nombre) if id
  end

  def forma_vida(row, index)
    id = row["forma_vida#{index}_id".to_sym]
    nombre = row["forma_vida#{index}".to_sym]
    FormaVida.new(id: id, nombre: nombre) if id
  end
end
