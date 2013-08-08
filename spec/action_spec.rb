require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe PorpoiseExternalActions::Action do

  let(:client) { PorpoiseExternalActions::Client.new }
  subject { PorpoiseExternalActions::Action.new({client: client }) }

end