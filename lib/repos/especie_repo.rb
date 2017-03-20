require_relative '../domains/especie'

class EspecieRepository
  def initialize(connection)
    @db = connection
  end

  # rubocop:disable Metric/MethodLength
  def find_all
    sql = 'select e. id,
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
            left join forma_vida v2 on e.forma_vida2_id = v2.id
          order by genero, nombre'

    especies = []
    @db.fetch(sql) do |row|
      especie_new = Especie.new(row)
      especies.push(especie_new)
    end
    especies
  end
end
