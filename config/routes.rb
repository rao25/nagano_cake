Rails.application.routes.draw do

  namespace :admin do
    get 'orders/index'
    get 'orders/show'
  end
  namespace :admin do
    get 'customers/edit'
    get 'customers/index'
    get 'customers/show'
  end
  namespace :admin do
    get 'genres/edit'
    get 'genres/index'
  end
  namespace :admin do
    get 'items/edit'
    get 'items/index'
    get 'items/new'
    get 'items/show'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'addresses/edit'
    get 'addresses/index'
  end
  namespace :public do
    get 'orders/confirm'
    get 'orders/thanks'
    get 'orders/index'
    get 'orders/show'
    get 'orders/new'
  end
  namespace :public do
    get 'cart_items/index'
  end
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  namespace :public do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
