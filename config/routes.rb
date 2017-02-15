Rails.application.routes.draw do
  resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end
  devise_for :users, :controllers => { registrations: 'registrations' }
  get 'notifications/:id/link_through', to: 'notifications#link_through',
                                        as: :link_through
  get 'notifications', to: 'notifications#index'
  patch 'notifications/:id/mark_read', to: 'notifications#mark_read',
                                     as: :mark_read
  patch 'notifications/:id/mark_unread', to: 'notifications#mark_unread',
                                       as: :mark_unread
  patch 'notifications/mark_read_all', to: 'notifications#mark_read_all',
                                     as: :mark_read_all
  get 'browse', to: 'posts#browse', as: :browse_posts
  post ':user_name/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':user_name/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user
  root 'posts#index'
  get ':user_name', to: 'profiles#show', as: :profile
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
  patch ':user_name/edit', to: 'profiles#update', as: :update_profile

end
