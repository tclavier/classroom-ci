require 'helper'

describe 'Classroom continuous integration Application' do
  it "get index" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to match(/Classroom continuous integration/)
  end
end
