Rails.application.routes.draw do
  root 'lists#index'
  resources :lists do
    # member do
    #  get :completed
    # end
    # resources :tasks do
    #   member do
    #     post :complete
    #   end
    # end
  end

  get     '/lists/:id/completed' => 'lists#show_completed', as: :completed_list
  delete  '/lists/:list_id/tasks/:id' => 'tasks#delete', as: :list_task
  post    '/lists/:list_id/tasks/:id/complete' => 'tasks#complete', as: :complete_list_task
  get     '/lists/:list_id/tasks' => 'tasks#index', as: :list_tasks
  post    '/lists/:list_id/tasks' => 'tasks#create'
  get     '/lists/:list_id/tasks/new' => 'tasks#new', as: :new_list_task
  # get   '/lists/:list_id/tasks/:id/edit' => 'tasks#edit', as: :edit_list_task
  # get   '/lists/:list_id/tasks/:id' =>  'tasks#show', as: :list_task
  patch   '/lists/:list_id/tasks/:id' => 'tasks#update'
  # put   '/lists/:list_id/tasks/:id' => 'tasks#update' #nesmie existovat
  # delete '/lists/:list_id/tasks/:id' => 'tasks#destroy'
end
