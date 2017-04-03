require_relative '../repos/color_repo'
require_relative 'lists_service'

class ColorService
  def initialize(connection)
    @repo = ColorRepository.new(connection)
  end

  def java_sqls
    colors = @repo.find_all
    ListsService.new.java_sqls(colors)
  end
end
