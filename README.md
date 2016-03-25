# ServiceAuthenticator

This is a lightweight gem built for the purposes of creating consistent configuration between services. Using this gem, you can store all service keys used for transactions between services on the ServiceAuthenticator::KeyChain and validate that any incoming requests to a service are using a valid key using ServiceAuthenticator::KeyValidator.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'service_authenticator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install service_authenticator

## Usage

ServiceAuthenticator was built to make the actual implementation of the gem as flexible as possible. With that in mind, here are a few examples of how ServiceAuthenticator can be used in an application:

1) Configuration of environment variables in a Rails initializer

```ruby
#config/initializers/client_keys.rb

keychain_config = YAML.load(File.read(Rails.root.join('config', 'client_keys.yml')))[Rails.env].try(:deep_symbolize_keys!) || {
  example_service_one: [ENV['EXAMPLE_SERVICE_ONE_CLIENT_KEY']],
  example_service_two: [ENV['EXAMPLE_SERVICE_TWO_CLIENT_KEY']],
}

ServiceAuthenticator::KeyChain.add_keys do |keys|
  keys.example_service_one = keychain_config[:example_service_one]
  keys.example_service_two = keychain_config[:example_service_two]
end
```

Those keys can later be accessed using
```ruby
ServiceAuthenticator::KeyChain.keys
```

2) Creating a controller concern to handle incoming client requests

```ruby
#app/controllers/concerns/client_key_validator.rb

module ClientKeyValidator
  def validate_client_key(client_service)
    unless key_validator(client_service).valid_key?(key)
      render json: { message: 'invalid client key' }, status: 401
    end
  end

  private

  def key
    @key ||= request.env["HTTP_CLIENT_KEY"] || params[:client_key]
  end

  def key_validator(client_service)
    @key_validator ||= ServiceAuthenticator::KeyValidator.new(client_service)
  end
end

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/service_authenticator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

