require 'engaging_networks/api'

module EngagingNetworks
  class Client < API

    def campaign
      @campaign ||= EngagingeNetworks::Campaign.new(client: self)
    end
    
    def supporter
      @supporter ||= EngagingeNetworks::Supporter.new(client: self)
    end

    def action
      @action ||= EngagingeNetworks::Action.new(client: self)
    end

  end
end