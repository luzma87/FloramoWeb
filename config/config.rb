require 'yaml'
require 'erb'

def config_file(path, sinatra = true)
  document = IO.read(path)
  document = ERB.new(document).result
  yaml = YAML.safe_load(document)

  if sinatra
    yaml.each_pair do |key, value|
      for_env = config_for_env(value)
      set key, for_env unless value && for_env.nil? && respond_to?(key)
    end
  end

  yaml
end

def config_for_env(hash)
  hash = define_value(hash)
  if hash.respond_to? :to_hash
    indifferent_hash = Hash.new { |hash2, key| hash2[key.to_s] if Symbol == key }
    indifferent_hash.merge hash.to_hash
  else
    hash
  end
end

def define_value(value)
  return value[environment.to_s] if value.respond_to?(:key) && value.key?(environment.to_s)
  return value['default'] if value.respond_to?(:key) && value.key?('default')
  value
end

private :config_for_env, :define_value
