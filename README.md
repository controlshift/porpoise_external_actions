porpoise_external_actions
=========================

An API client in ruby for the Purpose Platform External Actions API

[![Build Status](https://travis-ci.org/controlshift/porpoise_external_actions.png)](https://travis-ci.org/controlshift/porpoise_external_actions)

## Usage

```
require 'porpoise_external_actions'

# setup an API client.
client = PorpoiseExternalActions.new(host: 'test.herokuapp.com', username: 'controlshift', password: 'controlshift', movement_id: 'controlshift')

# send an action
response = client.action.create { source: 'foo', role: 'signer', action_slug: "slug", action_language_iso: "en", activity: "action_taken", user: { email: "foo@bar.com"}}

response # is a Farraday::Response object, API always returns an empty body with 201 status.
```

### Exceptions

* PorpoiseInvalidException - thrown for validation exceptions, when API return 422. Contains error message raw response.
* PorpoiseException - thrown when endpoint returns 500. Contains error message and raw http response


## Purpose API Documentation

https://github.com/PurposeOpen/Platform/wiki/Create-External-Activity-Event