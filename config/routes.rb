Loupe::Application.routes.draw do
	resources :services
	resources :disks do
		collection do
			get :raw
			get :rebuild
		end
	end
	
	root :to => "home#index"
end
