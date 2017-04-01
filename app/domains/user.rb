require 'hanami/validations'

class User
  include Hanami::Validations

  USER = 'user'.freeze
  ADMIN = 'admin'.freeze
  DEFAULT_ROLE = USER

  def initialize(params)
    params[:role] = DEFAULT_ROLE if params[:role].nil?

    @username = params[:username]
    @password = params[:password]
    @role = params[:role]
  end

  attr_reader :username
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

  def admin?
    role == ADMIN
  end

  def user?
    role == USER
  end

  validates :password, presence: true, size: 8..255, format: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).+\z/
  validates :username, presence: true, size: 6..12, format: /\A[a-zA-Z0-9_]+\z/
end
