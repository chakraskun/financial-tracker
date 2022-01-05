Rails.application.routes.draw do
  root 'sessions#new'
  get '/session', to: redirect('/')
  resource :session, controller: 'sessions', only:  %i[create]

  get '/sign_in', to: 'sessions#new', as: 'sign_in'
  delete '/sign_out', to: 'sessions#destroy'

  get 'service-worker',
    to: 'utils#service_worker',
    as: :service_worker

  resources :passwords, controller: "passwords", only: [:create, :new]

  resources :users do
    resource :password,
      controller: "passwords",
      only: [:create, :edit, :update]
  end

  namespace :admin do
    root 'dashboards#index'
    resources :projects
    resources :invoices
    resources :monthly_plans
    get 'ajax_dropdown_name/:invoice_type',
      to: 'invoices#ajax_dropdown_name',
      as: :dropdown_name_list
  end

  namespace :api do
    namespace :admin do
      namespace :projects do
        post 'get-all', to: 'index#show', as: :index
      end
      namespace :invoices do
        post 'get-income', to: 'index_income#show', as: 'index_income'
        post 'get-expense', to: 'index_expense#show', as: 'index_expense'
      end
    end
  end

  get '/forget_password', to: 'passwords#forget_password', as: 'new_forget_password'
  post '/forget_password', to: 'passwords#create_forget_password', as: 'forget_password'

end
