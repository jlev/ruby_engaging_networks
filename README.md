# engaging_networks

A ruby binding for the Engaging Networks API

[![Build Status](https://travis-ci.org/controlshift/ruby_engaging_networks.svg)](https://travis-ci.org/controlshift/ruby_engaging_networks)

## Usage

create a client object

```ruby
require 'engaging_networks'
en = EngagingNetworks.new({public_token: 'PUBLIC_TOKEN',private_token: 'PRIVATE_TOKEN'})
```

Get a campaign by id

```ruby
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
```

Duplicate a campaign


```ruby
action = en.campaign.duplicate reference_name: 'foo',
                      format_name: 'API New Supporter Template',
                      csv_string: 'Email,First Name,Last Name,City,Country Code,Country Name,Postal Code,Mobile Phone,Language,Originating Action',
                      csv_file_name: 'upload.csv',
                      segment_id: 'Test Segment Id',
                      segment_name: 'Test Segment',
                      template_campaign_id: 26967,
                      new_campaign_reference_name: 'New Test Campaign4'
action.job_id
=> '1234'
```

Search for a campaign by name (exact match only)

```ruby
action = en.campaign.search "Foo"
action.campaignName
=> 'Foo'
```

check if supporter exists

```ruby
en.supporter.exists? 'email@example.com'
=> false
```
create an action

```ruby
en.action.create(123, 456, 789, {'First name'=>'John', 'Last name'=>'Public', 'City'=>'New York', 'Email address'=>'email@example.com'})
=> true
```

And then check again, and now supporter exists!

```ruby
en.supporter.exists? 'email@example.com'
=> true
```

Supporters by date

```
en.supporter.export Date.new(2014,6,5)
=> [{...}]

```

## Copyright

Copyright (c) 2014 ControlShift Ltd. See LICENSE.txt for
further details.

