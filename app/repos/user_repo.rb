require_relative '../domains/user'

class UserRepository
  def initialize(connection)
    @db = connection[:users]
  end

  def find_one_by_username(username)
    result = @db.where(username: username)
    first_result = result.first
    user = nil
    user = User.new(first_result) if first_result
    user
  end

  def save(user)
    @db.insert(user.to_hash)
  end
end
