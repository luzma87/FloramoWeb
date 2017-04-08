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

  def find_all
    results = @db.order(:username)
    users = []
    results.each do |row|
      users.push(User.new(row))
    end
    users
  end

  def save(user)
    @db.filter('id = ?', user.id).update(user.to_save)
    user
  end

  def insert(user)
    id = @db.insert(user.to_save)
    user.id = id
    user
  end

  def delete(user)
    id = user.id
    @db.filter(id: id).delete
  end
end
