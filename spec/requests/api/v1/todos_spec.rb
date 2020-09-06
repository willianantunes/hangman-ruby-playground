require 'rails_helper'

RSpec.describe 'Todos API', :type => :request do
  # initialize test data
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  # Test suite for GET /api/v1/todos
  describe 'GET /api/v1/todos' do
    # make HTTP get request before each example
    before { get '/api/v1/todos' }

    it 'returns todos' do

      # Note `json` is a custom helper to parse JSON responses
      body_as_json = JSON.parse(response.body)
      expect(body_as_json).not_to be_empty
      expect(body_as_json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/todos/:id
  describe 'GET /api/v1/todos/:id' do
    before { get "/api/v1/todos/#{todo_id}" }

    context 'when the record exists' do
      it 'returns the todo' do
        body_as_json = JSON.parse(response.body)
        expect(body_as_json).not_to be_empty
        expect(body_as_json['id']).to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  # Test suite for POST /api/v1/todos
  describe 'POST /api/v1/todos' do
    # valid payload
    let(:valid_attributes) { {title: 'Learn Elm', created_by: '1'} }

    context 'when the request is valid' do
      before { post '/api/v1/todos', params: valid_attributes }

      it 'creates a todo' do
        body_as_json = JSON.parse(response.body)
        expect(body_as_json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/todos', params: {title: 'Foobar'} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/v1/todos/:id
  describe 'PUT /api/v1/todos/:id' do
    let(:valid_attributes) { {title: 'Shopping'} }

    context 'when the record exists' do
      before { put "/api/v1/todos/#{todo_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /api/v1/todos/:id
  describe 'DELETE /api/v1/todos/:id' do
    before { delete "/api/v1/todos/#{todo_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
