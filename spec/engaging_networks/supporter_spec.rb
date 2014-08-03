require 'spec_helper'

describe EngagingNetworks::Supporter do
  before(:each) do
    @en = EngagingNetworks.new(public_token: 'TEST_PUBLIC_TOKEN', private_token: 'TEST_PRIVATE_TOKEN')

    logger = double
    logger.stub(:debug).and_return(true)

    EngagingNetworks.stub(:logger).and_return(logger)
    Vertebrae::Base.stub(:logger).and_return(logger)
  end


  describe "retrieval" do
    let(:request_path) { 'https://e-activist.com/ea-dataservice/data.service' }

    before(:each) do
      stub_get(request_path).with(:query => hash_including({:service => 'SupporterData'})).
        to_return(:body => body, :status => status, :headers => {:content_type => "text/xml;charset=UTF-8"})
    end

    describe "supporter exists" do
      let(:body) { fixture('SupporterData/success.xml') }
      let(:status) { 200 }

      it 'should return true' do
        @en.supporter.exists?('ryan@grassriots.com').should == true
      end
    end

    describe 'supporter does not exist' do
      let(:body) { fixture('SupporterData/failure.xml') }
      let(:status) { 200 }

      it "should return false" do
        @en.supporter.exists?('fake@example.com').should == false
      end
    end
  end
end