class ApplicationController < Sinatra::Base

    helpers ApplicationHelper

    #set folder for templates to ../views, but make the path absolute
    set :views, File.expand_path('../../views', __FILE__)

    # don't enable logging when running tests
    configure :production, :development do
      enable :logging
    end

    # will be used to display 404 error pages
    not_found do
      title 'Not Found!'
      haml :not_found
    end

    get '/' do
      client = Cassandra.new('system')
      @keyspaces = client.keyspaces #array
      title 'Home Page'
      haml :home
    end

end
