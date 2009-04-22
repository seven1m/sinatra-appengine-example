require 'rubygems'
require 'app'
 
set :environment, :production
set :run, false
 
run Sinatra::Application
