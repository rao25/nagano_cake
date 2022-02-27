Rails.application.routes.draw do

# 顧客用
root to: "public/homes#top"
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  scope module: :public do
    get "/about", to: "homes#about"
    get "/customers/quit", to: "customers#quit"
    patch "/customers/out", to: "customers#out"
    resource :customers, only:[:show, :edit, :update]
    resources :products, only:[:index, :show]
    resources :cart_products, except:[:show, :new, :edit]
    delete "/cart_products", to: "cart_products#destroy_all"
    resources :orders, except:[:edit, :update, :destroy] do
      collection do
        get "complete"
        post "check"
      end
    end
    resources :deliveries, except:[:new, :show]
    
    # 検索機能
    get '/genre_search', to: "searches#genre_search"
    get '/product_search', to: "searches#product_search"
  end

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations,:passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    root to: 'homes#top'
    resources :items, except:[:destroy]
    resources :genres, only:[:index, :edit, :create, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:index, :show, :update]
    resources :order_details, only:[:update]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
