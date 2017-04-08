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
    sqls = ''
    sqls += dictionaries_sqls
    sqls += FamiliaService.new(@connection).java_all_sqls
    sqls += GeneroService.new(@connection).java_all_sqls
    sqls += EspecieService.new(@connection).java_all_sqls
    sqls + FotoService.new(@connection).java_all_sqls
  end

  def new_sqls
    ''
  end

  private

  def dictionaries_sqls
    sqls = ColorService.new(@connection).java_all_sqls
    sqls + FormaVidaService.new(@connection).java_all_sqls
  end
end
