require 'engaging_networks/request/token'

module EngagingNetworks
  class API < Vertebrae::API

    def default_options
      {
        user_agent: 'EngagingNetworksGem',
        host: 'e-activist.com',
        prefix: '/ea-dataservice',
        content_type: 'multipart/form-data'
      }
    end

    def setup
      puts connection.options

      connection.stack do |builder|
        #request middleware first, in order of importance
        builder.use EngagingNetworks::Request::TokenAuthentication,
          :token => connection.configuration.options[:token]

        builder.use Faraday::Request::Multipart

        #response  middleware second, in reverse order of importance
        builder.use FaradayMiddleware::ParseXml,  :content_type => /\bxml$/

        builder.use Faraday::Response::Logger if ENV['DEBUG']

        # builder.use  EngagingNetworks::Response::RaiseError
        builder.adapter connection.configuration.adapter
      end
    end
  end
end