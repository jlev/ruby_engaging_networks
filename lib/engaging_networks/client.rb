require 'engaging_networks/api'

module EngagingNetworks
  class Client < API

    def campaign
      @campaign ||= EngagingNetworks::Campaign.new(client: self)
    end
    
    def supporter
      @supporter ||= EngagingNetworks::Supporter.new(client: self)
    end

    def action
      @action ||= EngagingNetworks::Action.new(client: self)
    end

  end
end