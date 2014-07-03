module EngagingNetworks
  module Response
    class Object
      include Comparable

      attr_reader :fields

      def initialize(row)
        @fields = row['EaColumn'].inject({}) do |hash, item|
          hash[item['name']] = item['__content__']
          # TODO cast based on item['type']?
          hash
        end

        # create accessors for each field
        @fields.each do |name, val|
          # substitute underscore for space
          method_name = name.sub(' ','_')
          self.class.send(:define_method, method_name) {
            @fields[name]
          }
        end
      end

    end
  end
end
