module V1
  class ItemsController < ApplicationController
    before_action :set_todo
    before_action :set_todo_item, only: [:show, :update, :destroy]

    def_param_group :todo_item do
      param :todo_id, String, :desc => "Todo_id of the item", :required => true
      param :id, String, :desc => "Item_id", :required => true
    end

    def_param_group :item_param do
      param :name, String, :desc => "Name of the item", :required => true
      param :done, [true, false], :desc => "Item done or not", :required => true
    end

    # GET /todos/:todo_id/items
    api :GET, '/todos/:todo_id/items', "This shows items of given todo_id"
    error 500, 'Server crashed.'
    param :todo_id, String, :desc => "Todo_id of the items", :required => true
    def index
      json_response(@todo.items)
    end

    # GET /todos/:todo_id/items/:id
    api :GET, '/todos/:todo_id/items/:id', "This shows the item"
    error 500, 'Server crashed.'
    param_group :todo_item
    def show
      json_response(@item)
    end

    # POST /todos/:todo_id/items
    api :POST, '/todos/:todo_id/items', "This creates the item"
    error 500, 'Server crashed.'
    param :todo_id, String, :desc => "Todo_id of the item", required: true   
    param_group :item_param
    def create
      item = @todo.items.create!(item_params)
      json_response(item, :created)
    end

    # PUT /todos/:todo_id/items/:id
    api :PUT, '/todos/:todo_id/items/:id', "This updates the item"
    error 500, 'Server crashed.'
    param_group :todo_item
    param_group :item_param
    def update
      @item.update(item_params)
      json_response(@item, :ok)
      # head :no_content
    end

    # DELETE /todos/:todo_id/items/:id
    api :DELETE, '/todos/:todo_id/items/:id', "This deletes the item"
    error 500, 'Server crashed.'
    param_group :todo_item
    def destroy
      @item.destroy
      head :no_content
    end

    private

    def item_params
      params.permit(:name, :done)
    end

    def set_todo
      @todo = Todo.find(params[:todo_id])
    end

    def set_todo_item
      @item = @todo.items.find_by!(id: params[:id]) if @todo
    end
  end
end
