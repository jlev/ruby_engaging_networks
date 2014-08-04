require 'spec_helper'

describe EngagingNetworks::DuplicateAction do
  subject { EngagingNetworks::DuplicateAction.new(reference_name: 'reference', token: 'abc123', csv_string: fixture('api-supporter-template.csv'), csv_file_name: 'api-supporter-template.csv', format_name: 'format') }

  specify { expect(subject.valid?).to be_truthy}

  it 'should generate params' do
    p = subject.to_params
    expect(p[:formatName]).to eq('format')
    expect(p[:name]).to eq('reference')
    expect(p[:token]).to eq('abc123')
    expect(p[:upload]).not_to be_nil
  end
end