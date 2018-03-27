module V1
  class TodosController < ApplicationController
    before_action :set_todo, only: [:show, :update, :destroy]
    before_action :authorize_request
    set_pagination_headers :todos, only: [:index]

    # GET /todos
    api :GET, '/todos', "This is index of all todos"
    def index
      @todos = current_user.todos.paginate(page: params[:page], per_page: 20)
      json_response(@todos)
    end

    # POST /todos
    api :POST, '/todos', "This creates a new todo"
    param :title, String, :desc => "Title of the todo", :required => true
    def create
      @todo = current_user.todos.create!(todo_params)
      json_response(@todo, :created)
    end

    # GET /todos/:id
    api :GET, '/todos/:id', "This shows the todo of given id"
    param :id, Integer, :desc => "Todo_id"
    def show
      json_response(@todo)
    end

    # PUT /todos/:id
    api :PUT, '/todos/:id', "This updates the todo"
    param :id, Integer, :desc => "Todo_id"
    param :title, String, :desc => "Title of the todo"
    def update
      @todo.update(todo_params)
      json_response(@todo, :ok)
    end

    # DELETE /todos/:id
    api :DELETE, '/todos/:id', "This deletes the todo"
    param :id, Integer, :desc => "Todo_id"
    def destroy
      @todo.destroy
      head :no_content
    end

    private

    def todo_params
      # whitelist params
      params.permit(:title)
    end

    def set_todo
      @todo = Todo.find(params[:id])
    end
  end
end