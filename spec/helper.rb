ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'bundler'
Bundler.require

require 'classroomci'
require 'rack/test'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.color = true
end

def app
  ClassroomCI
end
