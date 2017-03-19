require 'sequel'
require 'dotenv/load'

require_relative '../../floramo_app'

module ConnectionHelper
  def pg_connection
    environment = ENV['RACK_ENV'] || 'development'
    connection_string = ENV['DATABASE_URL'] || ENV["DATABASE_URL_#{environment.upcase}"]
    # rubocop:disable Style/ClassVars
    @@db ||= Sequel.connect(connection_string)
  end
end
