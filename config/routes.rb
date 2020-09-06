Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # In our route definition, we're creating todo resource with a nested items resource.
  # This enforces the 1:m (one to many) associations at the routing level.
  resources :todos do
    resources :items
  end
  # When u issue the command:
  # ▶ rails routes
  #     Prefix Verb   URI Pattern                         Controller#Action
  # todo_items GET    /todos/:todo_id/items(.:format)     items#index
  #            POST   /todos/:todo_id/items(.:format)     items#create
  #  todo_item GET    /todos/:todo_id/items/:id(.:format) items#show
  #            PATCH  /todos/:todo_id/items/:id(.:format) items#update
  #            PUT    /todos/:todo_id/items/:id(.:format) items#update
  #            DELETE /todos/:todo_id/items/:id(.:format) items#destroy
  #      todos GET    /todos(.:format)                    todos#index
  #            POST   /todos(.:format)                    todos#create
  #       todo GET    /todos/:id(.:format)                todos#show
  #            PATCH  /todos/:id(.:format)                todos#update
  #            PUT    /todos/:id(.:format)                todos#update
  #            DELETE /todos/:id(.:format)                todos#destroy
  namespace :api do
    namespace :v1 do
      post 'cockatiel', to: 'games#something'
    end
  end
end
