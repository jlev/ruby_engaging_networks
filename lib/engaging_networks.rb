require 'vertebrae'

module EngagingNetworks
  extend Vertebrae::Base

  class << self
    def new(options = {})
      EngagingNetworks::Client.new(options)
    end
  end
end

require 'engaging_networks/version'
require 'engaging_networks/client'
require 'engaging_networks/base'
require 'engaging_networks/campaign'
require 'engaging_networks/supporter'
# require 'engaging_networks/action'

require 'engaging_networks/response/wrapper'
require 'engaging_networks/response/collection'

# require 'active_support/all'
# require 'action_kit_rest/railties' if defined? Rails