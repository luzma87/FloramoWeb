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

  def save(params_user)
    @repo.save(prepare(params_user))
  end

  def create(params_user)
    @repo.insert(prepare(params_user))
  end

  private

  def prepare(params_user)
    user = User.new(params_user)
    encrypted_password = BCrypt::Password.create(user.password)
    user.password = encrypted_password
    user
  end
end
