module EngagingNetworks
  class Base < Vertebrae::Model

    # examples from actionkit_rest, but sadly the EN API doesn't have generic endpoints

    # def list(filters = {})
    #   client.get_request(data_path, {service: service}.merge(filters))
    # end

    # def get(id)
    #   client.get_request(data_path, {service: service, id: id})
    # end

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

    def export_path
      "/ea-dataservice/export.service"
    end

    def action_path
      "/ea-action/action"
    end

  end
end