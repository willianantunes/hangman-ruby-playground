module API
  module V1
    class TodosController < ApplicationController
      before_action(:set_todo, only: [:show, :update, :destroy])

      def index
        @todos = Todo.all

        render json: @todos, status: :ok
      end

      def create
        # Raises a ActiveRecord::RecordInvalid error if validations fail
        @todo = Todo.create!(todo_params)

        render json: @todo, status: :created
      end

      def show
        render json: @todo, status: :ok
      end

      def update
        @todo.update(todo_params)
        head :no_content
      end

      def destroy
        @todo.destroy
        head :no_content
      end

      private

      def todo_params
        # whitelist params
        params.permit(:title, :created_by)
      end

      def set_todo
        # In the case where the record does not exist, ActiveRecord will throw an exception ActiveRecord::RecordNotFound
        @todo = Todo.find(params[:id])
      end
    end
  end
end
