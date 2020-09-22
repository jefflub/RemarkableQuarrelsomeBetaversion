require_relative '../main'
require 'rspec'
require 'rack/test'

RSpec.describe 'Main' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "says hello" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.content_type).to eq('application/json')
    body_hash = JSON.parse(last_response.body)
    expect(body_hash['text']).to eq ('Hello world!')
  end

  it "has a working db" do
    get '/db_count'
    expect(last_response).to be_ok
    expect(last_response.content_type).to eq('application/json')
    body_hash = JSON.parse(last_response.body)
    expect(body_hash['count']).to eq (3)
  end

  it "Adds data" do
    data = {name: 'Foo', price: 123.45}
    post '/create_record', data.to_json, "CONTENT_TYPE" => "application/json"
    expect(last_response).to be_ok
  end
end