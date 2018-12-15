Rails.application.routes.draw do
  
  # Transference
  get "/transfers", to: "transfer_asks#index", as: :transfers
  get "/transfer/new", to: "transfer_asks#new", as: :new_transfer
  post "/transfer/new", to: "transfer_asks#create", as: :create_transfer
  
  # Update status logic
  patch "/lots/:id", to: "lots#update_availability", as: :update_availability
  patch "/userss/:id", to: "users#update_payment", as: :update_payment

  root "pages#show", page: "home"
  get "/:token/confirm_email/", to: "users#confirm_email", as: 'confirm_email'
  get "/pages/*page" => "pages#show", as: 'pages'
  get "/pages/pagamento" => "pages#show", as: 'pagamento'
  get "/blocker", to: "pages#blocker", as: :blocker
  
  # Lecture inscription
  get '/lec_staffs', to: 'lec_staffs#index', as: :lec_staffs
  post '/lec_staffs', to: 'lec_staffs#create'
  get '/lec_staffs/new', to: 'lec_staffs#new', as: :new_lec_staff
  get '/lec_staffs/:id/edit', to: 'lec_staffs#edit', as: :edit_lec_staff
  get '/lec_staffs/:id', to: 'lec_staffs#show', as: :lec_staff
  patch '/lec_staffs/:id', to: 'lec_staffs#update'
  put '/lec_staffs/:id', to: 'lec_staffs#update'
  delete '/lec_staffs/:id', to: 'lec_staffs#destroy'
  
  # Workshop Inscription
  get '/work_staffs', to: 'work_staffs#index', as: :work_staffs
  post '/work_staffs', to: 'work_staffs#create'
  get '/work_staffs/new', to: 'work_staffs#new', as: :new_work_staff
  get '/work_staffs/:id/edit', to: 'work_staffs#edit', as: :edit_work_staff
  get '/work_staffs/:id', to: 'work_staffs#show', as: :work_staff
  patch '/work_staffs/:id', to: 'work_staffs#update'
  put '/work_staffs/:id', to: 'work_staffs#update'
  delete '/work_staffs/:id', to: 'work_staffs#destroy'
  
  #Lecture Inscription n' Staff
  patch 'lectures/:id/inscription', to: 'lectures#inscription', as: :lecture_inscription
  patch 'lectures/:id/add_lec_staff', to: 'lectures#add_lec_staff', as: :add_lec_staff
  
  #Lot Purchase
  patch 'lots/:id/purchase', to: 'lots#purchase', as: :lot_purchase
  
  #Workshop Inscription n' Staff
  patch 'workshops/:id/inscription', to: 'workshops#inscription', as: :workshop_inscription
  patch 'workshops/:id/add_work_staff', to: 'workshops#add_work_staff', as: :add_work_staff
  
  #Room Inscription
  patch 'rooms/:id/inscription', to: 'rooms#inscription', as: :room_inscription
  
  #Ranking
  get 'federations/ranking', to: 'federations#ranking', as: :ranking_federation
  get 'ejs/ranking', to: 'ejs#ranking', as: :ranking_ej
  
  #Control Panel
  get "/controlpanel", to: "pages#controlpanel", as: :control_panel
  delete "/control_panel/:id", to: "pages#remove_category", as: :remove_category
  
  #CRUDs
  get "/users/crud", to: "users#crud", as: :users_crud
  get "/lots/crud", to: "lots#crud", as: :lots_crud
  get "/hotels/crud", to: "hotels#crud", as: :hotels_crud
  
  # Criação direta no painel de controle
  post "/controlpanel/hotel", to: "pages#hotel_from_controller", as: :hotel_from_controller
  post "/controlpanel/room", to: "pages#room_from_controller", as: :room_from_controller
  post "/controlpanel/lecture", to: "pages#lecture_from_controller", as: :lecture_from_controller
  post "/controlpanel/workshop", to: "pages#workshop_from_controller", as: :workshop_from_controller
  post "/controlpanel/category", to: "pages#category_from_controller", as: :category_from_controller
  
  #Facebook Login
  match 'auth/:provider/callback', to: 'sessions#facecreate', via: [:get, :post]
	match 'auth/failure', to: redirect('/'), via: [:get, :post]
	match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  
  #Normal Login
  get 'sessions/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  #Signup
  get '/signup', to:'users#signup', as: :signup
  post '/signup', to: 'users#create'
  
  post '/checkouts/new', to: 'checkouts#create_with_room', as: :payment_room
  post '/checkouts/new', to: 'notifications#create'
  get '/checkouts/info', to: 'notifications#transaction_status', as: :checkout_info
  
  # resources users
  get '/users', to: 'users#index', as: :users
  post '/users', to: 'users#create'
  get '/users/new', to: 'users#new', as: :new_user
  get '/users/:id/edit', to: 'users#edit', as: :edit_user
  get '/users/:id', to: 'users#show', as: :user
  patch '/users/:id', to: 'users#update'
  put '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#destroy'
  
  # resources ejs
  get '/ejs', to: 'ejs#index', as: :ejs
  post '/ejs', to: 'ejs#create'
  get '/ejs/new', to: 'ejs#new', as: :new_ej
  get '/ejs/:id/edit', to: 'ejs#edit', as: :edit_ej
  get '/ejs/:id', to: 'ejs#show', as: :ej
  patch '/ejs/:id', to: 'ejs#update'
  put '/ejs/:id', to: 'ejs#update'
  delete '/ejs/:id', to: 'ejs#destroy'
  
  # resources staffs
  get '/staffs', to: 'staffs#index', as: :staffs
  post '/staffs', to: 'staffs#create'
  get '/staffs/new', to: 'staffs#new', as: :new_staff
  get '/staffs/:id/edit', to: 'staffs#edit', as: :edit_staff
  get '/staffs/:id', to: 'staffs#show', as: :staff
  patch '/staffs/:id', to: 'staffs#update'
  put '/staffs/:id', to: 'staffs#update'
  delete '/staffs/:id', to: 'staffs#destroy'
  
  # resources workshops
  get '/workshops', to: 'workshops#index', as: :workshops
  post '/workshops', to: 'workshops#create'
  get '/workshops/new', to: 'workshops#new', as: :new_workshop
  get '/workshops/:id/edit', to: 'workshops#edit', as: :edit_workshop
  get '/workshops/:id', to: 'workshops#show', as: :workshop
  patch '/workshops/:id', to: 'workshops#update'
  put '/workshops/:id', to: 'workshops#update'
  delete '/workshops/:id', to: 'workshops#destroy'
  
  # resources lectures
  get '/lectures', to: 'lectures#index', as: :lectures
  post '/lectures', to: 'lectures#create'
  get '/lectures/new', to: 'lectures#new', as: :new_lecture
  get '/lectures/:id/edit', to: 'lectures#edit', as: :edit_lecture
  get '/lectures/:id', to: 'lectures#show', as: :lecture
  patch '/lectures/:id', to: 'lectures#update'
  put '/lectures/:id', to: 'lectures#update'
  delete '/lectures/:id', to: 'lectures#destroy'
  
  # resources events
  get '/events', to: 'events#index', as: :events
  post '/events', to: 'events#create'
  get '/events/new', to: 'events#new', as: :new_event
  get '/events/:id/edit', to: 'events#edit', as: :edit_event
  get '/events/:id', to: 'events#show', as: :event
  patch '/events/:id', to: 'events#update'
  put '/events/:id', to: 'events#update'
  delete '/events/:id', to: 'events#destroy'
  
  # resources hotels
  get '/hotels', to: 'hotels#index', as: :hotels
  post '/hotels', to: 'hotels#create'
  get '/hotels/new', to: 'hotels#new', as: :new_hotel
  get '/hotels/:id/edit', to: 'hotels#edit', as: :edit_hotel
  get '/hotels/:id', to: 'hotels#show', as: :hotel
  patch '/hotels/:id', to: 'hotels#update'
  put '/hotels/:id', to: 'hotels#update'
  delete '/hotels/:id', to: 'hotels#destroy'
  
  # resources rooms
  get '/rooms', to: 'rooms#index', as: :rooms
  post '/rooms', to: 'rooms#create'
  get '/rooms/new', to: 'rooms#new', as: :new_room
  get '/rooms/:id/edit', to: 'rooms#edit', as: :edit_room
  get '/rooms/:id', to: 'rooms#show', as: :room
  patch '/rooms/:id', to: 'rooms#update'
  put '/rooms/:id', to: 'rooms#update'
  delete '/rooms/:id', to: 'rooms#destroy'
  
  # resources federations
  get '/federations', to: 'federations#index', as: :federations
  post '/federations', to: 'federations#create'
  get '/federations/new', to: 'federations#new', as: :new_federation
  get '/federations/:id/edit', to: 'federations#edit', as: :edit_federation
  get '/federations/:id', to: 'federations#show', as: :federation
  patch '/federations/:id', to: 'federations#update'
  put '/federations/:id', to: 'federations#update'
  delete '/federations/:id', to: 'federations#destroy'
  
  # resources archives
  get '/archives', to: 'archives#index', as: :archives
  post '/archives', to: 'archives#create'
  get '/archives/new', to: 'archives#new', as: :new_archive
  get '/archives/:id/edit', to: 'archives#edit', as: :edit_archive
  get '/archives/:id', to: 'archives#show', as: :archive
  patch '/archives/:id', to: 'archives#update'
  put '/archives/:id', to: 'archives#update'
  delete '/archives/:id', to: 'archives#destroy'
  
  # resources lots
  get '/lots', to: 'lots#index', as: :lots
  post '/lots', to: 'lots#create'
  get '/lots/new', to: 'lots#new', as: :new_lot
  get '/lots/:id/edit', to: 'lots#edit', as: :edit_lot
  get '/lots/:id', to: 'lots#show', as: :lot
  patch '/lots/:id', to: 'lots#update'
  put '/lots/:id', to: 'lots#update'
  delete '/lots/:id', to: 'lots#destroy'
  
  # resources checkouts
  get '/checkouts', to: 'checkouts#index', as: :checkouts
  post '/checkouts', to: 'checkouts#create'
  get '/checkouts/new', to: 'checkouts#new', as: :new_checkout
  get '/checkouts/:id/edit', to: 'checkouts#edit', as: :edit_checkout
  get '/checkouts/:id', to: 'checkouts#show', as: :checkout
  patch '/checkouts/:id', to: 'checkouts#update'
  put '/checkouts/:id', to: 'checkouts#update'
  delete '/checkouts/:id', to: 'checkouts#destroy'
  
  resources :password_resets
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
