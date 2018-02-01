Rails.application.routes.draw do
  devise_for :users
  root 'tasks#index'
  resources :tasks do 
  	 collection do
    	put 'start'
    	get 'report'
    	post 'sort'
  	end
  end
end
