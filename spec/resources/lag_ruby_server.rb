require 'cgi'
require 'socket'
require 'logger'
require 'json'
require 'faker'

logger = Logger.new(STDERR)

server = TCPServer.new(ENV.fetch('PORT', 8000).to_i)
time_to_be_delayed = ENV.fetch('DELAY_ANSWER_IN_SECONDS', 1).to_i

logger.debug("Time to be delayed between each request: #{time_to_be_delayed}")

movies = [Faker::Movies::BackToTheFuture, Faker::Movies::Departed, Faker::Movies::Ghostbusters,
          Faker::Movies::HarryPotter, Faker::Movies::HitchhikersGuideToTheGalaxy, Faker::Movies::Hobbit,
          Faker::Movies::Lebowski, Faker::Movies::LordOfTheRings, Faker::Movies::PrincessBride,
          Faker::Movies::StarWars, Faker::Movies::VForVendetta]

logger.debug("Number of available movies: #{movies.size}")

while (session = server.accept)
  logger.info('A new request was received!')
  Thread.new(session) do |session_threading|
    request = session_threading.gets
    logger.info("Request details: #{request}")

    match_data = /\?(?<params>[\w=+]+)?/.match(request)
    selected_movie =
      if match_data&.names&.include?('params')
        params = CGI.parse(match_data[:params])
        if params.key?('movie')
          movies.find { |m| m.name.split('::').last == params['movie'][0] }
        else
          movies.sample
        end
      else
        movies.sample
      end

    sleep time_to_be_delayed

    answer_request = lambda { |status, body|
      session_threading.print "HTTP/1.1 #{status}\r\n"
      session_threading.print "Content-Type: application/json\r\n"
      session_threading.print "\r\n"
      session_threading.print body.to_json

      session_threading.close
    }

    if selected_movie
      movie_name = selected_movie.name.split('::').last
      logger.info("Selected movie: #{movie_name}")
      some_character = selected_movie.character
      logger.info("Chosen character: #{some_character}")
      body_response = {character: some_character, movie: movie_name}
      answer_request.call(200, body_response)
    else
      body_response = {message: 'No movie found'}
      answer_request.call(404, body_response)
    end
  end
end
