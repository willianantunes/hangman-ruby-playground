module Api
  module V1
    class GamesController < ApplicationController
      def something
        greg = {cockatiel: 123}
        render json: greg, status: 201
      end
    end
  end
end
