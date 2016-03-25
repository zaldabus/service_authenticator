require 'spec_helper'

describe ServiceAuthenticator::KeyValidator do
  let(:key_validator) { described_class.new(:test) }

  describe '#initialize' do
    it 'raises an error if the internal key is set to nil' do
      expect {
        described_class.new(:test)
      }.to raise_error 'Test service key not configured'
    end
  end

  describe '#valid_key?(key)' do
    before(:all) do
      ServiceAuthenticator::KeyChain.keys.test = ['randomtestkey']
    end

    it 'returns true if service key matches one of the keys in the array of configured keys' do
      valid_key = ServiceAuthenticator::KeyChain.keys.test.first

      expect(key_validator.valid_key?(valid_key)).to eq true
    end

    it 'returns false if service key does not match one of the keys in the array of configured keys' do
      invalid_key = 'invalid_service_key'

      expect(key_validator.valid_key?(invalid_key)).to eq false
    end

    it 'returns false if service key is nil' do
      invalid_key = nil

      expect(key_validator.valid_key?(invalid_key)).to eq false
    end

    after(:all) do
      ServiceAuthenticator::KeyChain.keys.test = nil
    end
  end
end
