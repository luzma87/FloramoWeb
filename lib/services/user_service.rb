require_relative '../domains/user'
require_relative '../repos/user_repo'

class UserService
  def initialize(connection)
    connection = connection
    @repo = UserRepository.new(connection)
  end

  def login(username, password)
    user = @repo.find_one_by_username(username)
    return unless user
    user_encrypted_pass = BCrypt::Password.new(user.password)
    user if user_encrypted_pass == password
  end

  def create_admin
    user = @repo.find_one_by_username('luzma')
    return false if user
    user = User.new(username: 'luzma', password: BCrypt::Password.create('123456'), role: 'admin')
    @repo.save user
    true
  end
end
