# A class responsible for proxing to faraday response &
# or a pagination collection.
module EngagingNetworks
  module Response
    class Collection
      include Enumerable

      attr_reader :objects

      def initialize(data)
        @objects = data['EaRow']['EaColumn'].inject({}) do |hash, item|
          hash[item['name']] = item['__content__']
          # TODO cast based on item['type']?
          hash
        end
      end

      def each(&block)
        # TODO handle pagination somehow!
        objects.each do |o|
          block.call(o)
        end
      end
    end
  end
end
