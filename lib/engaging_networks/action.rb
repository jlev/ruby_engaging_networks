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
                       'ea.form.id' => formId}

      # merge params hashes
      post_params = {}
      post_params = post_params.merge(ajax_form_params)
      post_params = post_params.merge(client_params)
      post_params = post_params.merge(action_hash)

      client.post_request(action_path, post_params)
    end

  end
end