require 'engaging_networks/request/multitoken'

module EngagingNetworks
  class API < Vertebrae::API

    def request_with_wrapper( *args )
      EngagingNetworks::Response::Wrapper.new( request_without_wrapper( *args ) )
    end
    alias_method_chain :request, :wrapper

    def default_options
      {
        user_agent: 'EngagingNetworksGem',
        host: 'e-activist.com',
        content_type: 'multipart/form-data'
      }
    end

    def extract_data_from_params(params)
      # wrapper method from actionkit_rest
      # stub it out
      params
    end

    def setup
      connection.stack do |builder|
        #request middleware first, in order of importance
        builder.use EngagingNetworks::Request::MultiTokenAuthentication,
          :public_token => connection.configuration.options[:public_token],
          :private_token => connection.configuration.options[:private_token]

        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded

        #response middleware second, in reverse order of importance
        builder.use FaradayMiddleware::ParseXml,  :content_type => /\bxml$/
        
        builder.use Faraday::Response::Logger if ENV['DEBUG']

        builder.use EngagingNetworks::Response::RaiseError
        builder.adapter connection.configuration.adapter
      end
    end
  end
end