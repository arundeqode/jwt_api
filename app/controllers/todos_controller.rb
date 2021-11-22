class TodosController < ApplicationController
	# require_login is the method we define in application_controller.rb to check request.headers['token']

  before_action :require_login

  skip_before_action :require_login, only: [:index]

  # GET /todos
  def index
    todos = Todo.all

    render json: todos
  end

  def create
    todo = Todo.new(todos_params)
    if todo.save
    	render json: {todo: todo}, status: :ok
    else
    	render json: {errors: todo.errors}, status: :unprocessable_entity
    end
  end

  private

  def todos_params
  	params.require(:todo).permit(:title)
  end

end
