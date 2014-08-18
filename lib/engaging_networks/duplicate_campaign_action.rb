module EngagingNetworks
  class DuplicateCampaignAction < ActionModel
    # formatting / validation class for Duplicate Engaging Network Template Campaign (Endpoint)

    attr_accessor :reference_name, :token, :csv_string, :csv_file_name, :format_name, :broadcast_name, :broadcast_template_id, :segment_name, :segment_id, :template_campaign_id, :new_campaign_reference_name, :job_id

    validates :reference_name, :token, :csv_string, :csv_file_name, :format_name, presence: true

    def to_params
      csv = if csv_string.is_a?(String)
        StringIO.new(self.csv_string)
      else
        csv_string
      end

      params = {name: reference_name, #Arbitrary name - should be unique
                token: token, # Private token
                formatName: format_name, # Saved Format in EN
                upload: Faraday::UploadIO.new(csv, 'text/csv', csv_file_name), # Predefined Format
                segmentName: segment_name,
                segmentId: segment_id,
                campaignName: new_campaign_reference_name,
                campaignId: template_campaign_id,
                broadcastId: broadcast_template_id,
                broadcastName: broadcast_name}
      params.delete(:broadcastId) unless broadcast_template_id
      params.delete(:broadcastName) unless broadcast_name
      params.delete(:segmentId) unless segment_id
      params.delete(:segmentName) unless segment_name
      params.delete(:campaignId) unless template_campaign_id
      params.delete(:campaignName) unless new_campaign_reference_name
      params
    end
  end
end