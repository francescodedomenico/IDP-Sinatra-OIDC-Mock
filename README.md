# IDP Sinatra OIDC Mock

This is a Ruby project written using Sinatra DSL aimed to mock a OIDC Identity Provider / Authorization Server.

## Installation
In order to install dependencies it is recomended to use __bundler__

`
gem install bundler
`

then in the root dir of the repository:


`
bundle install
`

## Running the mock server 

`
ruby ./idp.rb
`

## Usage

Server runs on localhost port 4567 and exposes the following endpoints


### AZ Endpoint 

```Bash
http "localhost:4567/az?redirect_uri=https://google.com&state=dAS2sKipyDlp7lfdGbO8ydy9nyTEmZmhS108fKC3k5gwcDpH1Ka6cT9q233bYA3o"

HTTP/1.1 302 Found
Content-Length: 0
Content-Type: text/html;charset=utf-8
Location: https://google.com?code=e5c636c8-9fb8-4456-9f11-27974c81fb53&state=dAS2sKipyDlp7lfdGbO8ydy9nyTEmZmhS108fKC3k5gwcDpH1Ka6cT9q233bYA3o
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
```

* HTTP Method: __GET__
* Path: __/az__
* Query Params:
    *   __redirect_uri__ - url to be sent back with __authz_code__
    *   __state__ (optional) - state to be sent back on __redirect_uri__
* Response:
    * HTTP code - 302
    * HTTP Header Location - the __redirect_uri__ with a __randomly generated authz_code__
    * __code__ - sent back as a query string parameter in the given __redirect_uri__
    * __state__ (optional) sent back as a query string parameter in the given __redirect_uri__ if present in the initial request
### Token Endpoint

```Bash
http POST "localhost:4567/token"
HTTP/1.1 200 OK
Content-Length: 1283
Content-Type: application/json
X-Content-Type-Options: nosniff
```
Response body is statically read from __idp-response.json__:
```json
{
    "access_token": "1F2XXGuJ0e8Jd7aEk4dL98116x9hNt9j3pcw3cA34foUu3h64230Rc8C3oa5TTN4y4ir3352S93C61nT5Ms7I9yRfkYrDZ3641te63Qa1Wu6908yK1zSUtA4MkiTOXR6",
    "expires_in": "1800",
    "id_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJodHRwOi8vdGVyemFwYXJ0ZS5wb3N0ZS5pdDo4MDgzIiwibmJmIjoxNTQ1OTI0MzEwLCJhY3IiOiIzIiwic2NvcGUiOiIyIiwiaXNzIjoiaHR0cHM6Ly9wb3N0ZXBheS5pdCIsImF0X2hhc2giOiI3cjJsWm85NVQ0WFROS2JlQ25jTlFwaVVCdnN6Q0lRN3RBeEtreG1uclg4IiwiY2xhaW1zIjp7ImFkZHJlc3MiOiJWSUFMRSBFVVJPUEEgMTc1IDAwMTQ0IFJPTUEgUk0iLCJnZW5kZXIiOiJNIiwibW9iaWxlUGhvbmUiOiIrMzkzNzcxMTExMTExIiwiaWRDYXJkIjoiY2FydGFJZGVudGl0YSBBQjEyMzQ1NjcgY29tdW5lUm9tYSAyMDE4LTA0LTE3IDIwMjgtMDQtMTIiLCJmYW1pbHlOYW1lIjoiVmFsZW50ZSIsIm5hbWUiOiJGcmFuY2VzY28iLCJkYXRlT2ZCaXJ0aCI6IjE5ODAtMDEtMDEiLCJjb3VudHlPZkJpcnRoIjoiUk0iLCJmaXNjYWxOdW1iZXIiOiJUSU5JVC1WTE5GTlM4MEEwMUg1MDFVIiwiZW1haWwiOiJjbGF1ZGlvLnF1YXJlc2ltYUBwb3N0ZWNvbS5pdCJ9LCJuYW1laWQiOiJTUElELTY4MzMwM2EwLWUyMTItNDVlZS05MDJmLWE1ZjZiZTE2MjE2ZCIsImV4cCI6MTU0NTkyNDYxMCwiaWF0IjoxNTQ1OTI0MzEwLCJqdGkiOiI2YWNlZDhlZi05MWI2LTQwYmItOGM1Ni03MjJjOWM0NWQ5MjUiLCJpZCI6Il9mYmM3Y2U2OC1kODVlLTRiNWUtOWFjYi03MWE0YzUwMTM5NTYiLCJzaWQiOiJ2NnREeEdYWXREVnF1ek9jeDVIY1ZvVTRDS1p4OHdSeGNMOCtGVkFKSHFHUmxnVG0zbnNuSUVJamg1ZC9iTHBYIn0.BBrXQ-YEF1Pwqmo1lihEEzlnrSV4gO4taz_SGiVgRzI",
    "token_type": "Bearer"
}
```

* HTTP Method: __POST__
* Path: /token
* Response:
    * Content-Type: __application/json__
    * Response Body: the statically parsed __idp-response.json__


### Userinfo Endpoint

```Bash
http POST "localhost:4567/user_info"
Content-Length: 109
Content-Type: text/html;charset=utf-8
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
```
Response body is statically read from __user-info.json__:
```json
{
    "email": "testemail@test.com",
    "iat": 1516239022,
    "name": "John Doe",
    "sub": "1234567890"
}
```

* HTTP Method: __POST__
* Path: __/user_info__
* Response:
    * Content-Type: __application/json__
    * Response Body: the statically parsed __user-info.json__
