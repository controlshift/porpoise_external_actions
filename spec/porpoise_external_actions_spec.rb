require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe PorpoiseExternalActions do
  specify { subject.should respond_to :action }
  specify { subject.new.should be_a(PorpoiseExternalActions::Client)}
end
