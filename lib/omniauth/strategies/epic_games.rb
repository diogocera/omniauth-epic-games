require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class EpicGames < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = 'basic_profile'.freeze

      option :name, 'epic'

      option :client_options,
             site: 'https://api.epicgames.dev/epic',
             authorize_url: 'https://www.epicgames.com/id/authorize',
             token_url: 'oauth/v1/token'

      option :authorize_options, %i[scope permissions prompt]

      uid { debugger;raw_info['accountId'] }

      info do
        {
          name: raw_info['displayName']
        }
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get("https://api.epicgames.dev/epic/id/v1/accounts?accountId=#{access_token.response.parsed[:account_id]}").parsed.first
      end

      def build_access_token
        verifier = request.params["code"]
        params = {:redirect_uri => callback_url}.merge(token_params.to_hash(:symbolize_keys => true))
        params[:headers] = {'Authorization' => "Basic #{Base64.urlsafe_encode64([options.client_id, options.client_secret].join(':'))}" }
        params[:client_id] = options.client_id
        params[:scope] = DEFAULT_SCOPE
        params[:token_type] = 'eg1'

        client.auth_code.get_token(verifier, params, deep_symbolize(options.auth_token_params))
      end

      def authorize_params
        super.tap do |params|
          options[:authorize_options].each do |option|
            params[option] = request.params[option.to_s] if request.params[option.to_s]
          end

          params[:scope] ||= DEFAULT_SCOPE
        end
      end
    end
  end
end