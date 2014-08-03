require 'spec_helper'

describe EngagingNetworks::Campaign do
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
      stub_get(request_path).with(:query => hash_including({:service => 'EaCampaignInfo'})).
        to_return(:body => body, :status => status, :headers => {:content_type => "text/xml;charset=UTF-8"})
    end

    describe "exists" do
      let(:body) { fixture('EaCampaignInfo/success.xml') }
      let(:status) { 200 }

      it 'should exist' do
        c = @en.campaign.get(26967)
        c.campaignId.should == '26967'
        c.campaignName.should == 'API Test Campaign'
        c.campaignStatus.should == 'Live'
      end
    end

    describe 'does not exist' do
      let(:body) { fixture('EaCampaignInfo/failure.xml') }
      let(:status) { 200 }

      it "should be empty" do
        c = @en.campaign.get(1234)
        c.kind.should == :empty
        c.obj.should == nil
      end
    end
  end
end