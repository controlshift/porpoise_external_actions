module PorpoiseExternalActions
  class ExceptionMiddleware < Faraday::Response::Middleware

    def on_complete(response)
      status_code = response[:status].to_i
      if status_code == 500
        message = JSON.parse(response[:body])['error']
        raise PorpoiseException.new(message, response)
      elsif status_code == 422
        fields = JSON.parse(response[:body])
        raise PorpoiseInvalidException.new("validation error", response, fields)
      end
    end
  end

  class PorpoiseException < Exception
    attr_accessor :message, :http_response

    def initialize(message, response = nil)
      super(message)
      self.message = message
      self.http_response = response
    end
  end

  class PorpoiseInvalidException < PorpoiseException
    attr_accessor :fields

    def initialize message, response, fields = nil
      super(message, response)
      self.fields = fields
    end
  end

end