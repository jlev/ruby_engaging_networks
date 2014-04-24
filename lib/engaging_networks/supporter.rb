module EngagingNetworks
  class Supporter < Base
    def service
      'SupporterData'
    end

    def get(email)
      client.get_request(data_path, {service: service, email: email, token_type: 'private'})
    end
  end
end