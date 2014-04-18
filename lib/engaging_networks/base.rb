module EngagingNetworks
  class Base < Vertebrae::Model

    def list(filters = {})
      client.get_request(data_path, filters)
    end

    def get(id)
      client.get_request(data_path, {id: id})
    end

    def create(params)
      resp = client.post_json_request(import_path, params)
      id = extract_id_from_response(resp)
      get(id)
    end

    def update(id, params)
      client.put_json_request(import_path, params)
      get(id)
    end

    def import_path
      "import.service"
    end

    def data_path
      "data.service"
    end

    private

    def extract_id_from_response(resp)
      extract_id_from_location(resp.response.headers["location"])
    end

    def extract_id_from_location(location)
      location.scan(/\/(\d+)\/$/).first.first
    end
  end
end