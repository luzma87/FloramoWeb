require 'hanami/validations'

class FormaVida
  include Hanami::Validations

  def initialize(params)
    @id = params[:id]
    @nombre = params[:nombre]
  end

  attr_reader :id
  attr_accessor :nombre

  def icon
    "icons/ic_fv_#{@nombre}.png"
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
end
