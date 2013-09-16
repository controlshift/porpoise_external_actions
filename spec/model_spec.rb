require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe PorpoiseExternalActions::Model do

  it 'should normalize the base path' do
    subject.stub(:movement_id).and_return('controlshift')
    subject.normalized_base_path('foo').should == "api/movements/controlshift/foo/"
  end


end