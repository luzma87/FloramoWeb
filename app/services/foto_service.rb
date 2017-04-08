require_relative '../repos/foto_repo'

class FotoService
  def initialize(connection)
    @repo = FotoRepository.new(connection)
  end

  def save_batch(especie, params)
    params.keys.each do |param_key|
      args = {}
      args[:especie_id] = especie.id.to_s

      param_key.match(/^foto_i_\d/) { |_match| insert_foto(args, params[param_key]) }

      param_key.match(/^foto_\d+/) do |match|
        foto_id = match.to_s.delete('foto_')
        update_foto(args, foto_id, params[param_key])
      end
    end
  end

  def java_all_sqls
    lists_service = ListsService.new
    fotos = lists_service.java_insert_sqls(@repo.find_all)
    lists_service.sqls_function('Foto', fotos)
  end

  def java_sqls_since(date)
    lists_service = ListsService.new
    fotos = @repo.find_since(date)
    sqls = lists_service.java_delete_sqls(fotos, 'foto')
    sqls + lists_service.java_insert_sqls(fotos)
  end

  private

  def insert_foto(args, path)
    args[:path] = path
    foto = Foto.new(args)
    @repo.insert(foto)
  end

  def update_foto(args, id, path)
    args[:id] = id
    args[:path] = path
    foto = Foto.new(args)
    @repo.save(foto)
  end
end
