require 'hanami/validations'

class Especie
  include Hanami::Validations

  def initialize(params)
    @nombre = params[:nombre]
    @id_tropicos = params[:id_tropicos]
    @descripcion_es = params[:descripcion_es]
    @descripcion_en = params[:descripcion_en]
    @distribucion_es = params[:distribucion_es]
    @distribucion_en = params[:distribucion_en]
  end

  attr_accessor :nombre
  attr_accessor :id_tropicos
  attr_accessor :descripcion_es
  attr_accessor :descripcion_en
  attr_accessor :distribucion_es
  attr_accessor :distribucion_en

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
end
