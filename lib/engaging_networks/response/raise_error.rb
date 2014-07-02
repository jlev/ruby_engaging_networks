module EngagingNetworks
  module Response
    class RaiseError < Faraday::Response::Middleware

      def on_complete(response)
        status_code = response[:status].to_i
        
        # check standard http error responses
        if (400...600).include? status_code
          if status_code == 400
            raise EngagingNetworks::Response::ValidationError.new(url: response[:url].to_s, body: response[:body])
          elsif status_code == 404
            raise EngagingNetworks::Response::NotFound.new(response[:url].to_s)
          else
            raise Exception.new(error_message(response))
          end
        end

        # check for object not found responses, which are status_code == 200
        # TODO
      end

      def error_message(response)
        "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]} \n\n #{response[:body] if response[:body]}"
      end
    end

    class NotFound < Exception ; end
  end # Response::RaiseError
end