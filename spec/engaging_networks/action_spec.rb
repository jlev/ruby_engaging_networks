require 'spec_helper'

describe EngagingNetworks::Action do
  let!(:en) { EngagingNetworks.new(public_token: 'TEST_PUBLIC_TOKEN', private_token: 'TEST_PRIVATE_TOKEN') }

  describe 'create' do
    let(:request_path) { 'https://e-activist.com/ea-action/action' }
    let(:body) { fixture('action/success.json') }
    let(:status) { 200 }
    let(:input_hash) do
      { client_id: 123, campaign_id: 123, form_id: 123, first_name: 'George',
      last_name: 'Washington', city: 'Detroit', country: 'US', country_name: 'United States',
      email: 'george@washington.com', language_code: 'EN', address_line_1: 'address1', address_line_2: 'address2',
      post_code: '02052', state: 'MI', mobile_phone: '518-207-6768', originating_action: 'xxx'}
    end

    before(:each) do
      stub_post(request_path).with(:query => {'format' => 'json'}, :body => {"Address+Line+1"=>"address1", "Address+Line+2"=>"address2", "City"=>"Detroit", "Country"=>"US", "Country+Name"=>"United States", "Email+address"=>"george@washington.com", "First+name"=>"George", "Last+name"=>"Washington", "Mobile+Phone"=>"518-207-6768", "Opt+In+-+EN"=>"y", "Originating+Action"=>"xxx", "Post+Code"=>"02052", "State"=>"MI", "Title"=>"", "ea.AJAX.submit"=>"true", "ea.campaign.id"=>"123", "ea.campaign.mode"=>"DEMO", "ea.clear.campaign.session.id"=>"true", "ea.client.id"=>"123", "ea.form.id"=>"123", "ea.retain.account.session.error"=>"true", "ea.submitted.page"=>"1", "ea_javascript_enabled"=>"true", "ea_requested_action"=>"ea_submit_user_form", "v"=>"c%3AshowBuild"},
             :headers => {'Accept'=>'application/json;q=0.1', 'Accept-Charset'=>'utf-8', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'EngagingNetworksGem'}).
        to_return(:body => body, :status => status, :headers => {:content_type => "text/json;charset=UTF-8"})
    end

    describe 'success' do
      let(:body) { fixture('action/success.json') }

      it 'should create an action' do
        c = en.action.create(input_hash)
        expect(c.result).to be_truthy
      end
    end

    describe 'failure' do
      let(:body) { fixture('action/error.json') }

      it 'should raise' do
        expect { en.action.create(input_hash) }.to raise_error
      end
    end
  end
end