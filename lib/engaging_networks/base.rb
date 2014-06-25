module EngagingNetworks
  class Base < Vertebrae::Model

    def list(filters = {})
      client.get_request(data_path, {service: service}.merge(filters))
    end

    def get(id)
      client.get_request(data_path, {service: service, id: id})
    end

    # def create(params)
    #   resp = client.post_json_request(import_path, params)
    #   id = extract_id_from_response(resp)
    #   get(id)
    # end

    # def update(id, params)
    #   client.put_json_request(import_path, params)
    #   get(id)
    # end

    def import_path
      "/ea-dataservice/import.service"
    end

    def data_path
      "/ea-dataservice/data.service"
    end

    def action_path
      "/ea-action/action"
    end

    private

    # def extract_id_from_response(resp)
    #   extract_id_from_location(resp.response.headers["location"])
    # end

    # def extract_id_from_location(location)
    #   location.scan(/\/(\d+)\/$/).first.first
    # end
  end
end