require 'rubygems'
require 'sinatra'
require 'haml'
require 'json'
require 'cassandra'

get '/' do
  client = Cassandra.new('system')
  @keyspaces = client.keyspaces #array
  haml :home 
end

get '/keyspaces/:keyspace' do
  client = Cassandra.new(params[:keyspace])
  @keyspace = params[:keyspace]
  @cf = client.column_families #hash
  haml :cf
end

get '/keyspaces/:keyspace/:cf' do
  @client = Cassandra.new(params[:keyspace])
  @keyspace = params[:keyspace]
  @cf = params[:cf]
  haml :cfspecs
end
