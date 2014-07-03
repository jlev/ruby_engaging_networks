module EngagingNetworks
  class Action < Base
    # individual get unavailable
    # need to export and search actions
    def export(startDate)
      client.get_request(data_path, {startDate: startDate,
          token_type: EngagingNetworks::Request::MultiTokenAuthentication::PRIVATE})
    end

    def create(clientId, campaignId, formId, action_hash)
      # parameters required for fake ajax form submission
      ajax_form_params = {
        'ea.AJAX.submit' => true,
        'ea.submitted.page' => 1,
        'ea_requested_action' => 'ea_submit_user_form',
        'ea_javascript_enabled' => true
      }

      # check action hash for required keys
      required_keys = ['Email address', 'First name', 'Last name', 'City']
      required_keys.each do |key|
        unless action_hash.has_key? key
          raise ArgumentError, "#{key} required to create action"
        end
      end
      # TODO, check for one valid 'Opt In - LC' key

      # clientId, campaignId, formId
      client_params = {'ea.client.id' => clientId,
                       'ea.campaign.id' => campaignId,
                       'ea.form.id' => formId, 
                       'token_type' => EngagingNetworks::Request::MultiTokenAuthentication::PRIVATE}

      # merge params hashes
      p = {}
      p = p.merge(ajax_form_params)
      p = p.merge(client_params)
      p = p.merge(action_hash)

      #add token_type to action_path, for MultiTokenAuthentication
      u = "#{action_path}?token_type=private"

      # send post
      begin
        client.post_request(u, p)
      rescue => exception
        puts ''
        puts exception.backtrace
      end
    end

  end
end