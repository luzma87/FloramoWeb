require_relative '../domains/user'
require_relative '../repos/user_repo'

class UserService
  def initialize(connection)
    connection = connection
    @repo = UserRepository.new(connection)
  end

  def login(email, password)
    user = @repo.find_one_by_email(email)
    return unless user
    user_encrypted_pass = BCrypt::Password.new(user.password)
    user if user_encrypted_pass == password
  end
end
