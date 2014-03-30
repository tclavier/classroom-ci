require 'spec_helper'

describe 'Classroom continuous integration Application' do
  it "get index" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to match(/Classroom continuous integration/)
  end

  it "get new project form" do 
    get '/projects/new'
    expect(last_response).to be_ok
    expect(last_response.body).to match(/Register new project/)
  end

  it "create new project" do 
    post '/projects', url:"http://Mon/url/de/test"
    expect(last_response).to be_redirect
  end
end
