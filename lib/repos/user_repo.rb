require_relative '../domains/user'

class UserRepository
  def initialize(connection)
    @db = connection
  end

  def find_one_by_email(email)
    result = @db[:users].where(email: email)
    first_result = result.first
    user = nil
    user = User.new(first_result) if first_result
    user
  end
end
