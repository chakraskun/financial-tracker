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

  get '/forget_password', to: 'passwords#forget_password', as: 'new_forget_password'
  post '/forget_password', to: 'passwords#create_forget_password', as: 'forget_password'

end
