require 'spec_helper'

describe ServiceAuthenticator::KeyChain::KeyChainError::ServiceNotConfiguredError do
  context 'without a service parameter' do
    it 'raises default error message if the internal key is set to nil' do
      expect {
        raise described_class.new
      }.to raise_error 'Service key not configured'
    end
  end

  context 'with a service parameter' do
    it 'raises customized error message if the internal key is set' do
      expect {
        raise described_class.new(:test)
      }.to raise_error 'Test service key not configured'
    end
  end
end
