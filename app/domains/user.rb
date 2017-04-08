require 'hanami/validations'

class User
  include Hanami::Validations

  USER = 'user'.freeze
  EDITOR = 'editor'.freeze
  ADMIN = 'admin'.freeze
  DEFAULT_ROLE = USER

  def initialize(params)
    params[:role] = DEFAULT_ROLE if params[:role].nil?
    @id = params[:id]
    @username = params[:username]
    @password = params[:password]
    @role = params[:role]
  end

  attr_accessor :id
  attr_accessor :username
  attr_accessor :password
  attr_accessor :role

  def eql?(other)
    other && @username == other.username
  end

  def hash
    @username.hash
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
    hash
  end

  def admin?
    role == ADMIN
  end

  def user?
    role == USER
  end

  def editor?
    role == EDITOR
  end

  validates :password, presence: true, size: 8..255, format: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).+\z/
  validates :username, presence: true, size: 6..12, format: /\A[a-zA-Z0-9_]+\z/
end
