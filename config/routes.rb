Rails.application.routes.draw do
	root 'creators#index'
	resources :creators
	resources :clients
end
