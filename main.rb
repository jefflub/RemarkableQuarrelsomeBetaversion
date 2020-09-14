# Convert me to project mode before running!
# https://repl.it/site/docs/files#project-mode

require 'sinatra'

set :protection, :except => :frame_options
set :bind, '0.0.0.0'
set :port, 8080

get '/' do
  'Hello world!'
end

get '/test' do
  'Goodbye cruel world!'
end

get '/another_test' do
  'Another test'
end