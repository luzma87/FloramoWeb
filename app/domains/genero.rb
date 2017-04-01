require 'hanami/validations'

class Genero
  include Hanami::Validations

  def initialize(params)
    @id = params[:id]
    @nombre = params[:nombre]
    @familia = params[:familia]
  end

  attr_reader :id
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
end
