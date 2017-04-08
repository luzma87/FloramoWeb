require 'hanami/validations'

# noinspection RubyTooManyInstanceVariablesInspection
# rubocop:disable Metrics/ClassLength
class Especie
  include Hanami::Validations

  @fotos = []

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def initialize(params)
    @id = params[:id]
    @nombre = params[:nombre]
    @genero = params[:genero]
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

  attr_accessor :id
  attr_accessor :nombre
  attr_accessor :genero
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

  attr_accessor :fotos

  def nombre_cientifico
    "#{genero_nombre} #{@nombre}"
  end

  def thumbnail_path
    "encyclopedia/thumbnails/#{@thumbnail}"
  end

  def default_foto_path
    @fotos.first.foto_path unless @fotos.empty?
  end

  def color1_nombre
    @color1.nombre if @color1
  end

  def color2_nombre
    @color2.nombre if @color2
  end

  def forma_vida1_nombre
    @forma_vida1.nombre if @forma_vida1
  end

  def forma_vida2_nombre
    @forma_vida2.nombre if @forma_vida2
  end

  def genero_nombre
    @genero.nombre if @genero
  end

  def familia_nombre
    @genero.familia_nombre if @genero
  end

  def eql?(other)
    other && nombre_cientifico == other.nombre_cientifico
  end

  def hash
    [nombre_cientifico].hash
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

  # rubocop: disable Metrics/CyclomaticComplexity
  # rubocop: disable Metrics/PerceivedComplexity:
  def to_save
    hash = {}
    instance_variables.each do |var|
      ignored_fields = [:'@errors', :'@id']
      next if ignored_fields.include? var

      field = var.to_s.delete('@')

      case field
      when 'genero' then hash[:genero_id] = @genero.id
      when 'color1' then hash[:color1_id] = @color1 == '' ? nil : @color1
      when 'color2' then hash[:color2_id] = @color2 == '' ? nil : @color2
      when 'forma_vida1' then hash[:forma_vida1_id] = @forma_vida1 == '' ? nil : @forma_vida1
      when 'forma_vida2' then hash[:forma_vida2_id] = @forma_vida2 == '' ? nil : @forma_vida2
      else hash[field] = instance_variable_get(var)
      end
    end
    hash[:modified_date] = Time.now
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
      values += case field
                when 'genero' then "\\\"#{@genero.id}\\\", "
                when 'color1' then "\\\"#{@color1 ? @color1.id : nil}\\\", "
                when 'color2' then "\\\"#{@color2 ? @color2.id : nil}\\\", "
                when 'forma_vida1' then "\\\"#{@forma_vida1 ? @forma_vida1.id : nil}\\\", "
                when 'forma_vida2' then "\\\"#{@forma_vida2 ? @forma_vida2.id : nil}\\\", "
                else "\\\"#{instance_variable_get(var)}\\\", "
                end
    end
    "INSERT INTO especie (#{fields.chomp(', ')}) values(#{values.chomp(', ')})"
  end
end
