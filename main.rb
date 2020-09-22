require 'sinatra'
require 'sequel'

DB = Sequel.sqlite # memory database, requires sqlite3

DB.create_table :items do
  primary_key :id
  String :name
  Float :price
end

items = DB[:items] # Create a dataset

# Populate the table
items.insert(:name => 'abc', :price => rand * 100)
items.insert(:name => 'def', :price => rand * 100)
items.insert(:name => 'ghi', :price => rand * 100)

set :protection, except: :frame_options
set :bind, '0.0.0.0'
set :port, 8080

configure do
  set :protection, except: [:json_csrf]
end

get '/' do
  content_type :json
  { text: 'Hello world!' }.to_json
end

get '/db_count' do
  content_type :json
  { count: items.count }.to_json
end

post '/create_record' do
  data = JSON.parse request.body.read
  new_record_id = items.insert(data)
  new_record = items.where(id: new_record_id)
  content_type :json
  new_record.first.to_json
end
