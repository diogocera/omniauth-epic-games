require 'spec_helper'

describe OmniAuth::Strategies::EpicGames do
  let(:access_token) { instance_double('AccessToken', options: {}) }
  let(:parsed_response) { instance_double('ParsedResponse') }
  let(:response) { instance_double('Response', parsed: parsed_response) }

  let(:enterprise_site)          { 'https://some.other.site.com/api/v3' }
  let(:enterprise_authorize_url) { 'https://some.other.site.com/login/oauth/authorize' }
  let(:enterprise_token_url)     { 'https://some.other.site.com/login/oauth/access_token' }
  let(:enterprise) do
    OmniAuth::Strategies::EpicGames.new('GITHUB_KEY', 'GITHUB_SECRET',
                                      client_options: {
                                        site: enterprise_site,
                                        authorize_url: enterprise_authorize_url,
                                        token_url: enterprise_token_url
                                      })
  end

  subject do
    OmniAuth::Strategies::EpicGames.new({})
  end

  before(:each) do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  context 'client options' do
    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://api.epicgames.dev/epic')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('https://www.epicgames.com/id/authorize')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('oauth/v1/token')
    end

    describe 'should be overrideable' do
      it 'for site' do
        expect(enterprise.options.client_options.site).to eq(enterprise_site)
      end

      it 'for authorize url' do
        expect(enterprise.options.client_options.authorize_url).to eq(enterprise_authorize_url)
      end

      it 'for token url' do
        expect(enterprise.options.client_options.token_url).to eq(enterprise_token_url)
      end
    end
  end
end
