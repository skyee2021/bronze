Rails.application.routes.draw do
  root 'missions#index'
  resources :missions

  resources :users, only: [:create, :update, :edit] do
    collection do
      get :sign_up, action: 'new'
      
    end
  end

  namespace :admin, as: "qqaazzxxssww" do
    resources :users do
      member do
        get :locked
        get :unlocked
      end
    end
  end

  resources :sessions, path: 'users', only: [] do
    collection do
      get :log_in, action: 'new' #登入
      post :log_in, action: 'create'
      delete :log_out, action: 'destroy' #登出
    end
  end 
end
