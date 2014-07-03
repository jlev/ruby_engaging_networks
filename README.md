# engaging_networks

A ruby binding for the Engaging Networks API

## Usage

```ruby

require 'engaging_networks'
en = EngagingNetworks.new({public_token: 'PUBLIC_TOKEN',private_token: 'PRIVATE_TOKEN'})
campaign = en.campaign.get 456
campaign.obj
=> #<EngagingNetworks::Response::Object:0x00000101685f68
 @fields=
  {"clientId"=>"123",
   "campaignId"=>"456",
   "campaignStatus"=>"Live",
   "campaignName"=>"Test Campaign",
   "campaignExportName"=>"Test Campaign",
   "description"=>nil}>

en.supporter.exists? 'email@example.com'
=> false

en.action.create(123, 456, 789, {'First name'=>'John', 'Last name'=>'Public', 'City'=>'New York', 'Email address'=>'email@example.com'})
=> true

en.supporter.exists? 'email@example.com'
=> true

en.supporter.export Date.today.strftime('%m%d%Y')
=> [{...}]

```

## Copyright

Copyright (c) 2014 ControlShift Ltd. See LICENSE.txt for
further details.

