require 'ostruct'

module ServiceAuthenticator
  module KeyChain
    def self.add_keys
      yield keys
    end

    def self.keys
      @keys ||= OpenStruct.new
    end
  end
end
