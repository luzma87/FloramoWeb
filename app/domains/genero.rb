require 'hanami/validations'

class Genero
  include Hanami::Validations

  def initialize(params)
    @id = params[:id]
    @nombre = params[:nombre]
    @familia = params[:familia]
  end

  attr_accessor :id
  attr_accessor :nombre
  attr_accessor :familia

  def familia_nombre
    @familia.nombre
  end

  def eql?(other)
    other && @nombre == other.nombre && @familia == other.familia
  end

  def hash
    [@nombre, @familia].hash
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

  def to_save
    hash = {}
    instance_variables.each do |var|
      ignored_fields = [:'@errors', :'@id']
      next if ignored_fields.include? var
      field = var.to_s.delete('@')
      if field == 'familia'
        hash[:familia_id] = @familia.id
      else
        hash[var.to_s.delete('@')] = instance_variable_get(var)
      end
    end
    hash
  end

  # rubocop:disable Metrics/MethodLength
  def to_sql
    fields = []
    values = []
    instance_variables.each do |var|
      ignored_fields = [:'@errors']
      next if ignored_fields.include? var
      field = var.to_s.delete('@')

      fields.push(actual_field(field))
      str = if field == 'familia'
              @familia.id
            else
              instance_variable_get(var)
            end
      values.push("\\\"#{str}\\\"")
    end
    "INSERT INTO genero (#{fields.join(', ')}) values(#{values.join(', ')})"
  end

  def to_update_sql(_, _)
    values = []
    instance_variables.each do |var|
      ignored_fields = [:'@errors', :'@id']
      next if ignored_fields.include? var
      field = var.to_s.delete('@')
      value = actual_value(field, var)
      values.push("#{actual_field(field)} = \\\"#{value}\\\"")
    end
    "UPDATE genero SET #{values.join(', ')} WHERE id = \\\"#{@id}\\\""
  end

  private

  def actual_value(field, var)
    if field == 'familia'
      @familia.id
    else
      instance_variable_get(var)
    end
  end

  def actual_field(field)
    if field == 'familia'
      'familia_id'
    else
      field
    end
  end

end
