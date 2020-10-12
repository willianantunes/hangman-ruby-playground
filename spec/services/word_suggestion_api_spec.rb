# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WordSuggestionAPI do
  subject(:word_suggestion) { WordSuggestionAPI.new }
  it 'Should retrieve a movie' do
    movie_details = word_suggestion.random_movie

    expect(movie_details).to be_a_kind_of(Hash)
    expect(movie_details.keys).to contain_exactly('character', 'movie')
    expect(movie_details.values).to all(be_a(String))
  end
end
