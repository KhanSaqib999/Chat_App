Rails.application.routes.draw do
  get '/health', to: 'health#check'
  post '/login', to: 'users#create_or_find_user'
  patch 'users/update_token', to: 'users#update_token'
  post '/users/delete_token', to: 'users#delete_token'

  resources :messages do
    collection do
      delete 'delete-chat', to: 'messages#destroy_all'
    end
  end
  mount ActionCable.server => '/cable'
  mount ActionCable.server, at: '/users_cable'
  mount ActionCable.server, at: '/messages_cable'
end
