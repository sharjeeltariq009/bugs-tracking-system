Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "homes/index"
  root to: "homes#index"
  
  devise_for :users
  
 resources :projects do
  resources :bugs do
    member do
      patch :assign_to_self, :update_status # This creates the route for the action
    end
  end
end

end
