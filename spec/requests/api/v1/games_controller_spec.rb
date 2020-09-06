require 'rails_helper'

RSpec.describe 'Games API', type: :request do
  it 'Just a sample of returns status code 200' do
    post '/api/v1/cockatiel'

    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response).to have_http_status(201)
    body_as_json = JSON.parse(response.body)
    expect(body_as_json).not_to be_empty
    body_as_json.should == { 'cockatiel' => 123 }
  end
end
