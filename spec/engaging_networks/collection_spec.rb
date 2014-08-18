require 'spec_helper'

describe EngagingNetworks::Response::Collection do
  it 'should build an array of EngagingNetworks::Response::Objects' do
    col = EngagingNetworks::Response::Collection.new([
      { 'EaColumn' => [{"__content__"=>"132", "name"=>"clientId", "type"=>"xs:int"}, 
        {"name"=>"description", "type"=>"xs:string"}] },
      { 'EaColumn' => [{"__content__"=>"132", "name"=>"clientId", "type"=>"xs:int"}, 
        {"name"=>"description", "type"=>"xs:string"}] }
    ])
    expect(col.objects.class).to eq(Array)
    expect(col.objects.length).to eq(2)
    expect(col.objects.first.class).to eq(EngagingNetworks::Response::Object)
  end
end