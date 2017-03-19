require 'hanami/validations'

class User
  include Hanami::Validations

  USER = 'user'.freeze
  ADMIN = 'admin'.freeze
  DEFAULT_ROLE = USER

  def initialize(params)
    params[:role] = DEFAULT_ROLE if params[:role].nil?

    @email = params[:email]
    @password = params[:password]
    @role = params[:role]

  end

  attr_reader :email
  attr_accessor :password
  attr_accessor :role

  def eql?(other)
    other && @email == other.username
  end

  def hash
    @email.hash
  end

  alias == eql?

  def to_hash
    hash = {}
    instance_variables.each do |var|
      unless var == :'@errors'
        hash[var.to_s.delete('@')] = instance_variable_get(var)
      end
    end
    hash[:_id] = @email
    hash
  end

  def admin?
    role == ADMIN
  end

  def user?
    role == USER
  end

  validates :password, presence: true, size: 8..255, format: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).+\z/
  validates :email, presence: true, size: 6..254,
                    format: /\A[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\.)+[A-Za-z]{2,63}\z/
end
