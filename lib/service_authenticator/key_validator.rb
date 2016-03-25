module ServiceAuthenticator
  class KeyValidator
    KEY_CHAIN = KeyChain.keys

    def initialize(external_service)
      @external_service = external_service

      raise KeyChain::KeyChainError::ServiceNotConfiguredError.new(@external_service) if service_key_set.nil?
    end

    def valid_key?(service_key)
      return false if service_key.nil?
      service_key_set.include?(service_key)
    end

    private

    def service_key_set
      KEY_CHAIN.public_send(@external_service)
    end
  end
end
