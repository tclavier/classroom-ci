# encoding: utf-8
require "active_support/core_ext"
require_relative "project"

class ClassroomCI < Sinatra::Application
  
  configure do
    set :haml, :format => :html5
    set :root, File.dirname(__FILE__)+'/../'
    DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/database.db")
    DataMapper.finalize.auto_upgrade!
    enable :sessions
  end

  error do
    'Sorry there was a nasty error - ' + env['sinatra.error'].name
  end

  before do
    cache_control :public, :must_revalidate, :max_age => 60
  end

  get '/' do
    @projects = Project.all(:order => [ :points.desc ])
    haml :index
  end

  get '/projects/new' do
    haml :project_new
  end

  post '/projects' do
    project = Project.new()
    project.url = params[:url]
    logger.debug project
    if project.url[0,5] == "https"
      if project.save
        projectControler = ProjectControler.new
        projectControler.count_tests(project)
        redirect '/', :notice => 'The project was successfully created'
      end
    end
    redirect '/'
  end

  get '/build' do 
    projectControler = ProjectControler.new
    projectControler.perform
    redirect '/'
  end

  get '/script' do 
    projectControler = ProjectControler.new
    projectControler.script
    redirect '/'
  end
end

