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
    get "/customers/retention", to: "customers#retention"
    patch "/customers/withdraw", to: "customers#withdraw"
    resource :customers, only:[:show, :edit, :update]
    resources :items, only:[:index, :show]
    resources :cart_items, except:[:show, :new, :edit]
    delete "/cart_items", to: "cart_items#destroy_all"
    resources :orders, except:[:edit, :update, :destroy] do
      collection do
        get "thanks"
        post "confirm"
      end
    end
    resources :addresses, except:[:new, :show]
    
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
