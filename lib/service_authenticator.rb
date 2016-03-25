Gem.find_files("service_authenticator/**/*.rb").each { |path| require path }

module ServiceAuthenticator; end
