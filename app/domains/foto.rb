require 'hanami/validations'

class Foto
  include Hanami::Validations

  def initialize(params)
    @id = params[:id]
    @especie_id = params[:especie_id]
    @path = params[:path]
  end

  attr_reader :id
  attr_accessor :especie
  attr_accessor :path

  def foto_path
    "../encyclopedia/full_size/#{@path}"
  end

  def eql?(other)
    other && @especie_id == other.especie_id && @path == other.path
  end

  def hash
    [@especie_id, @path].hash
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
      hash[field] = instance_variable_get(var)
    end
    hash[:modified_date] = Time.now
    hash
  end

  def to_sql
    fields = []
    values = []
    instance_variables.each do |var|
      ignored_fields = [:'@errors']
      next if ignored_fields.include? var
      field = var.to_s.delete('@')
      fields.push(field)
      values.push("\\\"#{instance_variable_get(var)}\\\"")
    end
    "INSERT INTO foto (#{fields.join(', ')}) values(#{values.join(', ')})"
  end

  def to_update_sql(_, _)
    values = []
    instance_variables.each do |var|
      ignored_fields = [:'@errors', :'@id']
      next if ignored_fields.include? var
      field = var.to_s.delete('@')
      values.push("#{field} = \\\"#{instance_variable_get(var)}\\\"")
    end
    "UPDATE foto SET #{values.join(', ')} WHERE id = \\\"#{@id}\\\""
  end
end
