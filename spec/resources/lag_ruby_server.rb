require 'socket'
require 'logger'
require 'json'

logger = Logger.new(STDERR)

server = TCPServer.new(ENV.fetch('PORT', 8000).to_i)
time_to_be_delayed = ENV.fetch('DELAY_ANSWER_IN_SECONDS', 1).to_i
logger.debug("Time to be delayed between each request: #{time_to_be_delayed}")
characters = ["Aragorn", "Arwen", "Gimli", "Gollum", "Frodo", "Bilbo", "Legolas", "Melkor", "Galadriel", "Morgoth"]

while (session = server.accept)
  logger.info('A new request was received!')
  Thread.new(session) do |session_threading|
    request = session_threading.gets
    logger.info("Request details: #{request}")

    sleep time_to_be_delayed

    some_character = characters.sample
    body_response = {character: some_character}
    logger.info("Chosen character: #{some_character}")

    session_threading.print "HTTP/1.1 200\r\n"
    session_threading.print "Content-Type: application/json\r\n"
    session_threading.print "\r\n"
    session_threading.print body_response.to_json

    session_threading.close
  end
end
