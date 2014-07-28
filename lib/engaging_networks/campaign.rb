module EngagingNetworks
  class Campaign < Base
    def get(campaignId)
      client.get_request(data_path, {service: 'EaCampaignInfo', campaignId: campaignId,
            token_type: EngagingNetworks::Request::MultiTokenAuthentication::PUBLIC})
    end

    # TODO, search by campaign name

  end
end
