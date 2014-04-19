# engaging_networks

A ruby binding for the Engaging Networks API

## Usage

```ruby

require 'engaging_networks'
en = EngagingNetworks.new({token: 'TOKEN'})
campaign = en.campaign.get 'CAMPAIGN_ID'
supporter = en.supporter.get 'email@example.com'

```

## Copyright

Copyright (c) 2014 ControlShift Ltd. See LICENSE.txt for
further details.

