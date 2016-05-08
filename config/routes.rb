Rails.application.routes.draw do
  get '/' => 'index#index', as: :root

  devise_for :users, :skip => :all
  devise_scope :user do
    get    "/sign_in"      => "sessions#new"
    post   "/api/sign_in"  => "sessions#create"
    delete "/api/sign_out" => "sessions#destroy"

    get    "/sign_up"      => "registrations#new"
    post   "/api/sign_up"  => "registrations#create"
  end

  # get '/index' => 'mockup/index#index'
  # get '/graph' => 'mockup/index#graph'

  # get '/:page' => 'mockup/index#page', as: 'zhengdao'

  namespace :manager do
    get '/' => 'index#index'
    get '/sysinfo' => 'index#sysinfo'

    resources :users
    resources :stores
    resources :pay_defines
  end

  namespace :wizard do
    get '/' => 'index#index'
    get '/search/(:query)' => 'index#search', as: 'search'
    get 'queue' => 'index#queue'

    resources :patients do
      get :records_info, on: :member
      get :active_record_info, on: :member

      resources :records, shallow: true do 
        get :receive, on: :member
      end
    end
  end

  namespace :doctor do
    get '/' => 'index#index'
    get 'queue' => 'index#queue'
    get 'calendar' => 'index#calendar'

    resources :activities
  end
end
