Rails.application.routes.draw do
	root 'creators#index'
	resources :creators
end
