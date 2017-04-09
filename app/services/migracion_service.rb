require_relative 'color_service'
require_relative 'forma_vida_service'
require_relative 'familia_service'
require_relative 'genero_service'
require_relative 'especie_service'
require_relative 'foto_service'

class MigracionService
  def initialize(connection)
    @connection = connection
  end

  def all_sqls
    sqls = dictionaries_all_sqls
    sqls += FamiliaService.new(@connection).java_all_sqls
    sqls += GeneroService.new(@connection).java_all_sqls
    sqls += EspecieService.new(@connection).java_all_sqls
    sqls + FotoService.new(@connection).java_all_sqls
  end

  # rubocop:disable Metrics/AbcSize
  def sqls_since(date, flags)
    sqls = 'function updateIf() {<br/>'
    sqls += FamiliaService.new(@connection).java_sqls_since(date)
    sqls += GeneroService.new(@connection).java_sqls_since(date)
    sqls += EspecieService.new(@connection)
                          .java_sqls_since(date, flags[:with_description], flags[:only_description])
    sqls += FotoService.new(@connection).java_sqls_since(date) if flags[:with_fotos]
    sqls + '}'
  end

  private

  def dictionaries_all_sqls
    sqls = ColorService.new(@connection).java_all_sqls
    sqls + FormaVidaService.new(@connection).java_all_sqls
  end
end
