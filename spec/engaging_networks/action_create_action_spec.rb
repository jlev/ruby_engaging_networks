require 'spec_helper'

describe EngagingNetworks::ActionCreateAction do
  let(:country_code) { 'US' }
  let(:init_hash) { {client_id: 123, campaign_id: 123, form_id: 123, first_name: 'George',
                     last_name: 'Washington', city: 'Detroit', country: country_code, country_name: 'United States',
                     email: 'george@washington.com', language_code: 'EN', address_line_1: 'address1', address_line_2: 'address2',
                     post_code: '02052', state: 'MI', mobile_phone: '518-207-6768', originating_action: 'xxx' } }

  subject { EngagingNetworks::ActionCreateAction.new(init_hash) }

  describe 'initialization' do
    specify { expect(subject.valid?).to be_truthy }

    context 'invalid country code' do
      let(:country_code) { 'AA' }
      specify { expect(subject.valid?).to be_falsey }
    end
  end

  describe 'to_params' do
    specify { expect(subject.to_params['Opt In - EN']).to eq('y') }
  end
end