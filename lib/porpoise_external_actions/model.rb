module PorpoiseExternalActions
  class Model < Vertebrae::Model
    attr_accessor :movement_id

    def initialize(attrs = {})
      super(attrs)
      self.movement_id = client.connection.options[:movement_id] if client.present?
    end

    def normalized_base_path(path)
      "api/movements/#{movement_id}/#{path}/"
    end
  end
end