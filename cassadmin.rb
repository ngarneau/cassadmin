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

get '/keyspaces/:keyspace/columnfamilies' do
  client = Cassandra.new(params[:keyspace])
  @keyspace = params[:keyspace]
  @cfContent = client.column_families #hash
  haml :cf
end

get '/keyspaces/:keyspace/columnfamilies/:cf/keys' do
  @client = Cassandra.new(params[:keyspace])
  @keyspace = params[:keyspace]
  @cf = params[:cf]
  haml :cfspecs
end

get '/keyspaces/:keyspace/columnfamilies/:cf/keys/:key' do
  @client = Cassandra.new(params[:keyspace])
  @keyspace = params[:keyspace]
  @cf = params[:cf]
  @key = params[:key]
  @data = @client.get(@cf, @key)

  haml :key
end

helpers do
  def nav
    html = []

    html << "<li class=\"page\"><a href=\"/\">Keyspaces</a></li>"

    if @keyspace
      html << "<li><span class=\"divider\">/</span><a href=\"/keyspaces/#{@keyspace}/columnfamilies\">#{@keyspace}</a></li>"
      html << "<li class=\"page\"><span class=\"divider\">/</span><a href=\"/keyspaces/#{@keyspace}/columnfamilies\">Column families</a></li>"
    end

    if @cf
      html << "<li><span class=\"divider\">/</span><a href=\"/keyspaces/#{@keyspace}/columnfamilies/#{@cf}/keys\">#{@cf}</a></li>"
      html << "<li class=\"page\"><span class=\"divider\">/</span><a href=\"/keyspaces/#{@keyspace}/columnfamilies/#{@cf}/keys\">Keys</a></li>"
    end

    html << "<li><span class=\"divider\">/</span><a href=\"/keyspaces/#{@keyspace}/columnfamilies/#{@cf}/keys/#{@key}\">#{@key}</a></li>" if @key

    "<ul class=\"breadcrumb\">#{html.join}</ul>"
  end
end