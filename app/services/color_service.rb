require_relative '../repos/color_repo'
require_relative 'lists_service'

class ColorService
  def initialize(connection)
    @repo = ColorRepository.new(connection)
  end

  def java_all_sqls
    lists_service = ListsService.new
    colors = lists_service.java_sqls(@repo.find_all)
    lists_service.sqls_function('Colores', colors)
  end
end
