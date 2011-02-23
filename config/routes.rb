Cashflower::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  root :to => "static#index"
end
