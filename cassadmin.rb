class Cassadmin < Sinatra::Base

  Dir.glob('./{helpers,controllers}/*.rb').each { |file| require file }

  include KeyspacesController

  get '/' do
    client = Cassandra.new('system')
    @keyspaces = client.keyspaces #array
    haml :home
  end

  helpers do
    def title(value = nil)
      @title = value if value
      @title ? "Controller Demo - #{@title}" : "Controller Demo"
    end

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

end
