module PorpoiseExternalActions
  class Client < Vertebrae::API
    def action
      @action ||= PorpoiseExternalActions::Action.new(client: self)
    end

    def default_options
      {
        user_agent: 'PorpoiseExternalActionsGem',
        prefix: '',
        content_type: 'application/x-www-form-urlencoded'
      }
    end

    def request(method, path, params, options) # :nodoc:
      if !::Vertebrae::Request::METHODS.include?(method)
        raise ArgumentError, "unknown http method: #{method}"
      end

      path =  connection.configuration.prefix + '/' + path

      ::Vertebrae::Base.logger.debug "EXECUTED: #{method} - #{path} with #{params} and #{options}"

      connection.connection.send(method) do |request|

        case method.to_sym
          when *(::Vertebrae::Request::METHODS - ::Vertebrae::Request::METHODS_WITH_BODIES)
            request.url(path, params)
          when *::Vertebrae::Request::METHODS_WITH_BODIES
            request.path = path
            request.body = params unless params.empty?
        end
      end
    end

    def setup
      connection.stack do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Vertebrae::Request::BasicAuth, connection.configuration.authentication if connection.configuration.authenticated?

        builder.use Faraday::Response::Logger if ENV['DEBUG']

        builder.use PorpoiseExternalActions::ExceptionMiddleware # Vertebrae::Response::RaiseError
        builder.adapter connection.configuration.adapter
      end
    end
  end
end