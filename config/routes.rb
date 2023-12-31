Rails.application.routes.draw do


  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  root to: "public/homes#top"
  
  namespace :public do
    get '/about', to: "homes#about", as: 'about'
    resources :items, only: [:show, :index ]

    resource :customer, only: [:show]
    get '/information/edit', to: 'customers#edit', as: 'edit_customer'
    patch '/information/update', to: 'customers#update', as: 'update_customer'
    get '/confirmation', to: "customers#confirmation", as: 'customers_confirmation'
    patch '/withdrawal', to: 'customers#withdrawal', as: 'customers_withdrawal'


    resources :cart_items, only: [:index, :update, :destroy, :create] do
    collection do
    delete :destroy_all
    end
  end
    resources :orders, only: [:new, :index, :show, :create ]
    post '/confirm', to: 'orders#confirm', as: 'orders_confirm'
    get '/complete', to: 'orders#complete', as: 'orders_complete'

  end

  namespace :admin do
    root to: "homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit, :update ]
    resources :customers, only: [:index, :show, :edit, :update ]
    resources :orders, only: [:show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
