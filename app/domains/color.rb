require 'hanami/validations'

class Color
  include Hanami::Validations

  def initialize(params)
    @id = params[:id]
    @nombre = params[:nombre]
  end

  attr_reader :id
  attr_accessor :nombre

  def icon
    "../icons/ic_cl_#{@nombre}.png"
  end

  def eql?(other)
    other && @nombre == other.nombre
  end

  def hash
    @nombre.hash
  end

  alias == eql?

  def to_hash
    hash = {}
    instance_variables.each do |var|
      unless var == :'@errors'
        hash[var.to_s.delete('@')] = instance_variable_get(var)
      end
    end
    hash
  end

  def to_sql
    fields = ''
    values = ''
    instance_variables.each do |var|
      ignored_fields = [:'@errors']
      next if ignored_fields.include? var
      field = var.to_s.delete('@')
      fields += "#{field}, "
      values += "\\\"#{instance_variable_get(var)}\\\", "
    end
    "INSERT INTO color (#{fields.chomp(', ')}) values(#{values.chomp(', ')})"
  end
end
