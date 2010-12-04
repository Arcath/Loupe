Loupe::Application.routes.draw do
	resources :services
	resources :disks do
		collection do
			get :raw
		end
	end
	
	root :to => "home#index"
end
