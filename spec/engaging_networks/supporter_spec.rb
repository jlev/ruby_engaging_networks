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

  describe "export" do
    let(:request_path) { 'https://e-activist.com/ea-dataservice/export.service' }

    before(:each) do
      stub_get(request_path).with(:query => "startDate=07072014&token=TEST_PRIVATE_TOKEN").
        to_return(:body => body, :status => status, :headers => {:content_type => "text/xml;charset=UTF-8"})
    end

    describe "array of supporters" do
      let(:body) { fixture('SupporterData/aoxml_success_array.xml') }
      let(:status) { 200 }

      it 'should return true' do
        resp = @en.supporter.export(Date.new(2014,7,7))
        expect(resp.obj.class).to eq(EngagingNetworks::Response::Collection)
        expect(resp.obj.objects.first.first_name).to eq("Foo")
      end
    end

    describe "a single supporter" do
      let(:body) { fixture('SupporterData/aoxml_success.xml') }
      let(:status) { 200 }

      it 'should return true' do
        resp = @en.supporter.export(Date.new(2014,7,7))
        expect(resp.obj.class).to eq(EngagingNetworks::Response::Object)
        expect(resp.obj.first_name).to eq("Foo")
      end
    end
  end
end