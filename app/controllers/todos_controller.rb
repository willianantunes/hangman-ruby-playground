class TodosController < ApplicationController
  before_action(:set_todo, only: [:show, :update, :destroy])

  # GET /todos
  def index
    @todos = Todo.all

    render json: @todos, status: :ok
  end

  # POST /todos
  def create
    # Raises a ActiveRecord::RecordInvalid error if validations fail
    @todo = Todo.create!(todo_params)

    render json: @todo, status: :created
  end

  # GET /todos/:id
  def show
    render json: @todo, status: :ok
  end

  # PUT /todos/:id
  def update
    @todo.update(todo_params)
    head :no_content
  end

  # DELETE /todos/:id
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
