Cashflower::Application.routes.draw do

  #match "/iphone.manifest" => IPHONE_CACHE_MANIFEST

  resources :cashflows, :only => [:index, :create]

  devise_for :users, :controllers => { :registrations => "registrations" }
  root :to => "static#index"
end
