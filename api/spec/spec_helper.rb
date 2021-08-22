require_relative "routes/signup"
require_relative "routes/sessions"
require_relative "routes/equipos"
require_relative "libs/mongo"
require_relative "helpers"
require "digest/md5"

def to_md5(pass)
  return Digest::MD5.hexdigest(pass)
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  
  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    users = [
      { name: "Carolina Silva", email: "carolina_silva@rocklov.com", password: to_md5("pwd123") },
      { name: "Anunciante", email: "anunciante@rocklov.com", password: to_md5("pwd123") },
      { name: "Joao Oliveira", email: "joao_oli@rocklov.com", password: to_md5("pwd123") },
      { name: "Phoebe", email: "phoebe@rocklov.com", password: to_md5("pwd123") },
      { name: "Chandler", email: "chandler@rocklov.com", password: to_md5("pwd123") },
    ]

    MongoDB.new.drop_danger
    MongoDB.new.insert_users(users)
  end

end
