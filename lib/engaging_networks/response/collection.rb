# A class responsible for proxing to faraday response &
# or a pagination collection.
module EngagingNetworks
  module Response
    class Collection
      include Enumerable

      attr_reader :objects

      def initialize(data)
        #todo, inject over rows / columns
        @objects = data['EaRow']['EaColumn'].inject({}) do |hash, item|
          hash[item['name']] = item['__content__']
          #todo, cast based on item['type']?
          hash
        end
      end

      def each(&block)
        # todo handle pagination somehow!
        objects.each do |o|
          block.call(o)
        end
      end
    end
  end
end
