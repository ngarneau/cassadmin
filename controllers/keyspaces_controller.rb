module KeyspacesController

  def self.included(app)
    app.get '/keyspaces/:keyspace/columnfamilies' do
      client = Cassandra.new(params[:keyspace])
      @keyspace = params[:keyspace]
      @cfContent = client.column_families #hash
      haml :cf
    end

    app.get '/keyspaces/:keyspace/columnfamilies/:cf/keys' do
      @client = Cassandra.new(params[:keyspace])
      @keyspace = params[:keyspace]
      @cf = params[:cf]
      haml :cfspecs
    end

    app.get '/keyspaces/:keyspace/columnfamilies/:cf/keys/:key' do
      @client = Cassandra.new(params[:keyspace])
      @keyspace = params[:keyspace]
      @cf = params[:cf]
      @key = params[:key]
      @data = @client.get(@cf, @key)

      haml :key
    end
  end

end
