Cashflower::Application.routes.draw do

  resources :cashflows, :only => [:index, :create]

  devise_for :users, :controllers => { :registrations => "registrations" }
  root :to => "static#index"
end
