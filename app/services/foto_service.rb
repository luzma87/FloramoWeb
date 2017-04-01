require_relative '../repos/foto_repo'

class FotoService
  def initialize(connection)
    @repo = FotoRepository.new(connection)
  end

  def save_batch(especie, params)
    params.keys.each do |param_key|

      args = Hash.new
      args[:especie_id] = 'pepe'
      args[:especie_id] = "#{especie.id}"


      param_key.match(/^foto_i_\d/) do |match|
        args[:path] = params[param_key]
        foto = Foto.new(args)
        @repo.insert(foto)
        # p "insert #{params[param_key]}"
      end

      param_key.match(/^foto_\d+/) do |match|
        args[:id] = match.to_s.delete('foto_')
        args[:path] = params[param_key]
        foto = Foto.new(args)
        @repo.save(foto)
        # p "update #{id} #{params[param_key]}"
      end
    end

  end
end
