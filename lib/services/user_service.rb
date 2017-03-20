require_relative '../domains/user'
require_relative '../repos/user_repo'

class UserService
  def initialize(connection)
    @repo = UserRepository.new(connection)
  end

  def login(username, password)
    user = @repo.find_one_by_username(username)
    return unless user
    user_encrypted_pass = BCrypt::Password.new(user.password)
    user if user_encrypted_pass == password
  end
end
