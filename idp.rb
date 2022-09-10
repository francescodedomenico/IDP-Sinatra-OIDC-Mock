require 'sinatra'
require 'sinatra/json'
require 'json'
require 'net/http'
require 'securerandom'

get '/az' do
    parameters = {}
    if params['state'] != NIL then
        parameters = {
            :code => SecureRandom.uuid,
            :state => params['state']
        }
    else
        parameters = {
            :code => SecureRandom.uuid
        }
    end
    if params['redirect_uri'].include? 'https://'  then
        redirect_uri = params['redirect_uri']
        host = redirect_uri["https://"] = ""
        redirect_uri  = URI::HTTPS.build(host: redirect_uri, query: URI.encode_www_form(parameters))
    else
        redirect_uri = params['redirect_uri']
        host = redirect_uri["http://"] = ""
        redirect_uri  = URI::HTTP.build(host: redirect_uri, query: URI.encode_www_form(parameters))
    end
    redirect redirect_uri
end

post '/token' do
    file = File.read('./idp-response.json')
    parsed_response = JSON.parse(file)
    json parsed_response
end

post '/user_info' do
    file = File.read('./user-info.json')
    parsed_response = JSON.parse(file)
    return file
end