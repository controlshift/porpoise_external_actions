require 'vertebrae'
require 'porpoise_external_actions/model'
require 'porpoise_external_actions/action'
require 'porpoise_external_actions/client'

module PorpoiseExternalActions
  extend Vertebrae::Base

  class << self
    def new(options = {})
      PorpoiseExternalActions::Client.new(options)
    end
  end
end