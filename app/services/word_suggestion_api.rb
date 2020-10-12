# frozen_string_literal: true

class WordSuggestionAPI
  ENDPOINT = URI.parse Settings::RUNNER_ENDPOINT
  REQUEST_PATH_V1_MOVIES = URI::HTTP.build(path: Settings::RUNNER_REQUEST_PATH_V1_MOVIES)

  def initialize
    retry_options = {
      max: 3,
      interval: 0.05,
      interval_randomness: 0.5,
      backoff_factor: 0.1
    }

    @connection = Faraday.new(ENDPOINT, request: { timeout: 5 }) do |setup|
      setup.request :retry, retry_options
      setup.response :json
      setup.adapter Faraday.default_adapter
    end
  end

  def random_movie
    # TODO: how to work with errors? Does Faraday throw an exception given a 5XX error?
    # TODO If the guy returns an body different than JSON, then raise a contract exception
    # TODO Log what is happening as a means to inform or TSHOOT purpose
    response = @connection.get REQUEST_PATH_V1_MOVIES.path

    response.body
  end
end
