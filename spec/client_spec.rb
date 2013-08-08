require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe PorpoiseExternalActions::Client do

  describe "initialized" do
    subject { described_class.new(options) }
    let(:handlers) { subject.connection.stack.handlers }


    context 'process_basic_auth' do
      let(:options) { { :basic_auth => 'login:password' } }
      let(:config) { subject.connection.configuration  }
      specify { config.username.should eq 'login' }
      specify { config.password.should eq 'password' }
      specify { handlers.should include(Vertebrae::Request::BasicAuth)  }
    end

    context 'stack' do
      let(:options) { {} }
      specify { handlers.should include(Faraday::Request::UrlEncoded)  }
      specify { handlers.should include(Vertebrae::Response::RaiseError)  }
    end
  end
end
