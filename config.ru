require 'sinatra/base'
require 'rubygems'
require 'haml'
require 'json'
require 'cassadmin'
require 'cassandra'

Dir.glob('./{helpers,controllers}/*.rb').each { |file| require file }
run Cassadmin.new
