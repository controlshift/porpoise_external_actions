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

    def setup
      connection.stack do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Vertebrae::Request::BasicAuth, connection.configuration.authentication if connection.configuration.authenticated?

        builder.use Faraday::Response::Logger if ENV['DEBUG']

        builder.use Vertebrae::Response::RaiseError
        builder.adapter connection.configuration.adapter
      end
    end
  end
end