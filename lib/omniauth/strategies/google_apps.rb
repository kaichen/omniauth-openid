require 'omniauth/strategies/open_id'

module OmniAuth
  module Strategies
    class GoogleApps < OmniAuth::Strategies::OpenID
      def initialize(app, store = nil, options = {}, &block)
        options[:name] ||= 'google_apps'
        if store.is_a?(Hash) and options.empty?
          options = store
        else
          options[:store] = store
        end
        super(app, options, &block)
      end

      def get_identifier
        OmniAuth::Form.build(:title => 'Google Apps Authentication') do
          label_field('Google Apps Domain', 'domain')
          input_field('url', 'domain')
        end.to_response
      end

      def identifier
        domain = options[:domain] || request['domain']
        return nil if domain.nil?
        "https://www.google.com/accounts/o8/site-xrds?ns=2&hd=#{domain}"
      end
    end
  end
end
