Rails.application.routes.draw do
  resources :projects do
    resources :comments, module: :projects
    resources :tasks do
      resources :comments, module: :tasks
    end
  end

  devise_for :users,
    path: '',
    path_names: {
      sign_in: :login,
      sign_out: :logout,
      registration: :signup
    },
    controllers: {
      sessions: :sessions,
      registrations: :registrations
    }
end
