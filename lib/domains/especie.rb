require 'hanami/validations'

# noinspection RubyTooManyInstanceVariablesInspection
class Especie
  include Hanami::Validations

  # rubocop:disable Metric/MethodLength
  # rubocop:disable Metric/AbcSize
  def initialize(params)
    @nombre = params[:nombre]
    @genero = params[:genero]
    @familia = params[:familia]
    @id_tropicos = params[:id_tropicos]
    @color1 = params[:color1]
    @color2 = params[:color2]
    @forma_vida1 = params[:forma_vida1]
    @forma_vida2 = params[:forma_vida2]
    @descripcion_es = params[:descripcion_es]
    @descripcion_en = params[:descripcion_en]
    @distribucion_es = params[:distribucion_es]
    @distribucion_en = params[:distribucion_en]
    @thumbnail = params[:thumbnail]
  end

  attr_accessor :nombre
  attr_accessor :genero
  attr_accessor :familia
  attr_accessor :id_tropicos
  attr_accessor :color1
  attr_accessor :color2
  attr_accessor :forma_vida1
  attr_accessor :forma_vida2
  attr_accessor :descripcion_es
  attr_accessor :descripcion_en
  attr_accessor :distribucion_es
  attr_accessor :distribucion_en
  attr_accessor :thumbnail

  def nombre_cientifico
    "#{@genero} #{@nombre}"
  end

  def thumbnail_path
    "encyclopedia/thumbnails/#{@thumbnail}"
  end

  def eql?(other)
    other && nombre_cientifico == other.nombre_cientifico && familia == other.familia
  end

  def hash
    [nombre_cientifico, @familia].hash
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
