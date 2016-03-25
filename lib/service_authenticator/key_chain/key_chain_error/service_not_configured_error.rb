require 'active_support/inflector'

module ServiceAuthenticator
  module KeyChain
    module KeyChainError
      class ServiceNotConfiguredError < StandardError
        def initialize(service = nil)
          @service = service
        end

        def to_s
          if @service
            "#{titleized_service} service key not configured"
          else
            "Service key not configured"
          end
        end

        private

        def titleized_service
          @service.to_s.titleize
        end
      end
    end
  end
end
