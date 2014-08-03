module EngagingNetworks
  class Campaign < Base
    def get(campaignId)
      client.get_request(data_path, {service: 'EaCampaignInfo', campaignId: campaignId,
            token_type: EngagingNetworks::Request::MultiTokenAuthentication::PUBLIC})
    end

    def duplicate(referenceName, csvFileName, formatName, segmentName, segmentId, templateCampaignId, newCampaignReferenceName)
      params = {name: referenceName, upload: formatName, csvFile: Faraday::UploadIO.new(csvFileName, 'csv'), 
            segmentName: segmentName, segmentId: segmentId, campaignName: newCampaignReferenceName,
            templateCampaignId: templateCampaignId, token_type: EngagingNetworks::Request::MultiTokenAuthentication::PRIVATE}
      params.delete(:segmentId) unless segmentId
      params.delete(:segmentName) unless segmentName
      params.delete(:campaignName) unless newCampaignReferenceName
      client.post_request(import_path, params)
    end
    
    # TODO, search by campaign name

  end
end
