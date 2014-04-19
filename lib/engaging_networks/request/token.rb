module EngagingNetworks
  module Request
    class TokenAuthentication < Faraday::Middleware
      # Request middleware to always pass token as url parameter

      def call(env)
        env[:url].query << "&token=#{@token}"
        #todo, smarter way to append this using URI:: ?

        @app.call env
      end

      def initialize(app, *args)
        @app = app
        puts args

        options = args.extract_options!
        if options.has_key? :token
          @token = options[:token]
        else
          @token = nil
        end
        
      end
    end # TokenAuthentication
  end
end