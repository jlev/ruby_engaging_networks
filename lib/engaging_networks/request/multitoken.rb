module EngagingNetworks
  module Request
    class MultiTokenAuthentication < Faraday::Middleware
      PUBLIC = 1
      PRIVATE = 2

      # Request middleware looks for token_type in http params, replaces with actual token value

      def call(env)
        # decode url param string to hash
        if env[:url].query
          params = URI.decode_www_form(env[:url].query).to_h
        else
          params = {}
        end

        if params.has_key? 'token_type'
          token_type = params['token_type'].to_i #because it got stringified in the form

          # insert necessary token
          if token_type == MultiTokenAuthentication::PRIVATE
            params["token"] = @private_token
          elsif token_type == MultiTokenAuthentication::PUBLIC
            params["token"] = @public_token
          else
            raise ArgumentError, "invalid token_type #{token_type}"
          end

          # remove token_type
          params.delete('token_type')

          # encode and return to env
          env[:url].query = URI.encode_www_form(params)
        else
          # no token_type passed, ignore
        end

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