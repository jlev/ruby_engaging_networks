module EngagingNetworks
  class Supporter < Base

    def data(email)
      # data.service only returns Y/N values on which fields contain data, not actual data contained
      client.get_request(data_path, {service: 'SupporterData', email: email,
          token_type: EngagingNetworks::Request::MultiTokenAuthentication::PUBLIC, time: Time.now.to_i}) # cache bust the time parameter.
    end

    def exists?(email)
      return data(email).obj.supporterExists == 'Y'
    end

    def export(startDate)
      # startDate must be MMDDYYY and within last 45 days
      client.get_request(export_path, {startDate: startDate.strftime("%m%d%Y"),
          token_type: EngagingNetworks::Request::MultiTokenAuthentication::PRIVATE})

      # TODO, filter for specific fields
    end
  end
end