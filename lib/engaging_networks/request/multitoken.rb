module EngagingNetworks
  module Request
    class MultiTokenAuthentication < Faraday::Middleware
      # Request middleware to always pass public/private token as url parameter

      def call(env)
        #decode params
        params = URI.decode_www_form(env[:url].query).to_h
        token_type = params['token_type']

        #insert necessary token
        if token_type.equal? 'private'
          params["token"] = @private_token
        else token_type.equal? 'public'
          params["token"] = @public_token
        end

        #remove token_type
        params.delete('token_type')

        #encode and return to env
        env[:url].query = URI.encode_www_form(params)

        @app.call env
      end

      def initialize(app, *args)
        @app = app

        options = args.extract_options!
        if options.has_key? :public_token
          @public_token = options[:public_token]
        else
          @public_token = nil
        end

        if options.has_key? :private_token
          @private_token = options[:private_token]
        else
          @private_token = nil
        end

      end
    end # MultiTokenAuthentication
  end
end