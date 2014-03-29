# encoding: utf-8

class Project 
  include DataMapper::Resource
  property :id,      Serial
  property :url,     Text, :required => true
  property :student, Text
end

class ClassroomCI < Sinatra::Application
  @flash

  configure do
    set :haml, :format => :html5
    set :root, File.dirname(__FILE__)+'/../'
    DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/database.db")
    DataMapper.finalize.auto_upgrade!
  end

  error do
    'Sorry there was a nasty error - ' + env['sinatra.error'].name
  end

  before do
    cache_control :public, :must_revalidate, :max_age => 60
  end

  get '/' do
    haml :index
  end
end

