module EngagingNetworks
  class Supporter < Base

    def exists?(email)
      # data.service only returns Y/N values on which fields contain data, not actual data contained
      s = client.get_request(data_path, {service: 'SupporterData', email: email, token_type: 'public'})
      return s.obj.supporterExists == 'Y'
    end

    def export(startDate)
      # startDate must be within last 45 days
      client.get_request(export_path, {startDate: startDate, token_type: 'private'})
    end
  end
end