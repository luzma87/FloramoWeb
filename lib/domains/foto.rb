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
    "encyclopedia/new/#{@path}"
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
end
