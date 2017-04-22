Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "meetups#index"
  resources :meetups do
  	resources :posts
  end
  
  namespace :api, :defaults => { :format => :json } do
  	namespace :v1 do

  		post "/signup" => "auth#signup"
  		post "/login" => "auth#login"
  		post "/logout" => "auth#logout"
  		get "/meetups" => "meetups#index"
  	end
  end

end
