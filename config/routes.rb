Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
  get 'notifications/:id/link_through', to: 'notifications#link_through',
                                        as: :link_through
  get 'notifications', to: 'notifications#index'
  root 'posts#index'
  get ':user_name', to: 'profiles#show', as: :profile
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
  patch ':user_name/edit', to: 'profiles#update', as: :update_profile
  resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end
end
