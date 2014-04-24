module EngagingNetworks
  module Request
    class MultiTokenAuthentication < Faraday::Middleware
      # Request middleware to always pass public/private token as url parameter

      def call(env)
        #decode existing params
        params = URI.decode_www_form(env[:url].query)

        pry

        #insert necessary token
        if @options.token_type == 'private'
          params << ["token", @private_token]
        elif @options.token_type == 'public'
          params << ["token", @public_token]
        end

        #return to env
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