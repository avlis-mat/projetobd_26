Rails.application.routes.draw do
  get "painel/index"

  # Login
  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :painel, only: [:index] do
    collection do
      post :executar_procedure
    end
  end

  resources :formularios do
  member do
    get  :responder      # exibe as questões para responder
    post :enviar_respostas  # salva todas as respostas de uma vez
  end
end

resources :resposta, controller: "resposta" do
  collection do
    get :minhas_respostas  # agrupa respostas do aluno por formulário
  end
end

  # Recursos principais
  resources :resposta
  resources :admins
  resources :professors
  resources :alunos
  resources :usuarios
  resources :formularios
  resources :turmas
  resources :modelos
  resources :questaos
  resources :materia
  resources :departamentos
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "painel#index"
end
