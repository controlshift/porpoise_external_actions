module PorpoiseExternalActions
  class Action < PorpoiseExternalActions::Model
    def base_path
      normalized_base_path('external_activity_events')
    end

    def create(params)
      client.post_request(base_path, params)
    end
  end
end