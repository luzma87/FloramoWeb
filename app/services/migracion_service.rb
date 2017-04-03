require_relative 'color_service'
require_relative 'forma_vida_service'
require_relative 'familia_service'
require_relative 'genero_service'
require_relative 'especie_service'

class MigracionService
  def initialize(connection)
    @connection = connection
  end

  def all_sqls
    sqls = ''
    sqls += colores_sqls
    sqls += formas_vidas_sqls
    sqls += familias_sqls
    sqls += generos_sqls
    sqls += especies_sqls
    sqls
  end

  private

  def formas_vidas_sqls
    sql = 'function insertFormasVida() {<br/>'
    sql += FormaVidaService.new(@connection).java_sqls
    sql += '}<br/><br/>'
  end

  def colores_sqls
    sql = 'function insertColores() {<br/>'
    sql += ColorService.new(@connection).java_sqls
    sql += '}<br/><br/>'
  end

  def familias_sqls
    sql = 'function insertFamilias() {<br/>'
    sql += FamiliaService.new(@connection).java_sqls
    sql += '}<br/><br/>'
  end

  def generos_sqls
    sql = 'function insertGeneros() {<br/>'
    sql += GeneroService.new(@connection).java_sqls
    sql += '}<br/><br/>'
  end

  def especies_sqls
    sql = 'function insertEspecies() {<br/>'
    sql += EspecieService.new(@connection).java_sqls
    sql += '}<br/><br/>'
  end
end
