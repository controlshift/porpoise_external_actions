require 'vertebrae'
require 'porpoise_external_actions/model'
require 'porpoise_external_actions/action'
require 'porpoise_external_actions/client'
require 'porpoise_external_actions/exception_middleware'

module PorpoiseExternalActions
  extend Vertebrae::Base

  class << self
    def new(options = {})
      PorpoiseExternalActions::Client.new(options) do

      end
    end
  end
end