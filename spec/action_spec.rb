require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe PorpoiseExternalActions::Action do

  let(:client) { PorpoiseExternalActions::Client.new(host: 'test.com', username: 'controlshift', password: 'controlshift', movement_id: 'controlshift') }
  subject { PorpoiseExternalActions::Action.new({client: client }) }

  context 'with an http post' do
    let(:request_path) { '/api/movements/controlshift/external_activity_events/' }
    let(:request_body) { params }
    let(:status) { 201 }
    let(:body) {''}

    let(:params) { { source: 'foo', role: 'signer', action_slug: "slug", action_language_iso: "en", activity: "action_taken", user: {email: 'foo@bar.com'}} }

    before(:each) do
      stub_post(request_path).with(body: request_body).to_return(:body => body, :status => status,
                                                                 :headers => { content_type: "application/json; charset=utf-8"})
    end

    describe "creating actions" do
      context 'post returns 500' do
        let(:status) { 500 }
        let(:body){ '{"error":"no_method_error"}' }

        it 'should return an error hash when a remote exception occurs' do
          lambda { subject.create(params) }.should raise_exception(PorpoiseExternalActions::PorpoiseException, 'no_method_error')
        end
      end


      context 'post returns 201' do
        let(:status) {201}
        it 'should return true when a successful action is created' do
          subject.create(params).class.should == Faraday::Response
        end
      end

      context 'post returns a 422' do
        let(:status) {422}
        let(:body) { '{"email":["is invalid"]}' }

        it 'should return a hash when a validation error occurs' do
          lambda { subject.create(params) }.should raise_exception(PorpoiseExternalActions::PorpoiseInvalidException, 'validation error')
        end
      end
    end

  end



end