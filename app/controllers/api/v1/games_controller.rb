# frozen_string_literal: true

module API
  module V1
    class GamesController < ApplicationController
      def something
        greg = { cockatiel: 123 }
        render json: greg, status: :created
      end
    end
  end
end
