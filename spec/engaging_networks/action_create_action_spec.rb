require 'spec_helper'

describe EngagingNetworks::ActionCreateAction do
  let(:country_code) { 'US' }
  let(:init_hash) { {client_id: 123, campaign_id: 123, form_id: 123, first_name: 'George',
                     last_name: 'Washington', city: 'Detroit', country: country_code, country_name: 'United States',
                     email: 'george@washington.com', address_line_1: 'address1', address_line_2: 'address2',
                     post_code: '02052', state: 'MI', mobile_phone: '518-207-6768', originating_action: 'xxx',
                     additional_fields: additional_fields, opt_in: opt_in } }

  subject { EngagingNetworks::ActionCreateAction.new(init_hash) }
  let(:additional_fields) { {} }
  let(:opt_in) { nil }

  describe 'initialization' do
    specify { expect(subject.valid?).to be_truthy }

    context 'invalid country code' do
      let(:country_code) { 'AA' }
      specify { expect(subject.valid?).to be_falsey }
    end
  end

  describe 'to_params' do
    context 'nil additional fields' do
      let(:additional_fields) { nil }

      specify { expect(subject.to_params['First name']).to eq('George') }
    end

    context 'no additional fields' do
      specify { expect(subject.to_params['First name']).to eq('George') }
    end

    context 'some additional fields' do
      let(:additional_fields) { {'Interested In Volunteering' => 'y', 'Shirt Size' => 'XXL'} }

      specify { expect(subject.to_params['Interested In Volunteering']).to eq('y') }
      specify { expect(subject.to_params['Shirt Size']).to eq('XXL') }
    end

    context 'opt in' do
      it 'should set nil to N' do
        expect(subject.to_params['Opt in']).to eq('N')
      end

      context 'opted in' do
        let(:opt_in) { true }

        it 'should transform truth into Y' do
          expect(subject.to_params['Opt in']).to eq('Y')
        end
      end

      context 'opted in' do
        let(:opt_in) { false }

        it 'should transform false into N' do
          expect(subject.to_params['Opt in']).to eq('N')
        end
      end
    end
  end
end
