# A class responsible for proxing to faraday response &
# or a pagination collection.
module EngagingNetworks
  module Response
    class Collection
      include Enumerable

      attr_reader :objects

      def initialize(data)
        @objects = data.inject([]) do |arr, row|
          arr << EngagingNetworks::Response::Object.new(row)
        end
      end

      def each(&block)
        @objects.each do |o|
          block.call(o)
        end
      end
    end
  end
end
