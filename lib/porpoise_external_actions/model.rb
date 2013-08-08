module PorpoiseExternalActions
  class Model < Vertebrae::Model
    attr_accessor :movement_id

    def normalized_base_path(path)
      "api/movements/#{movement_id}/external_activity_events#{path}/"
    end
  end
end