Rails3BootstrapDeviseCancan::Application.routes.draw do
  resources :evaluations
  resources :statistics
  resources :schools

  authenticated :user do
    root :to => redirect("/evaluations")
  end
  
  devise_for :users 

  devise_scope :user do
    root to: "devise/sessions#new"
  end
  resources :users

  match "/evaluation/:id/evaluate", to: "evaluations#evaluate", :as => :evaluate, :via => :get
  match "/evaluate/receive", to: "evaluations#receive", :as => "receive", :via => :post
  match "/evaluations/:id/generate_inform", to: "evaluations#generate_inform", :as => :generate_inform
  match  "/upload", to: "upload#index"
  match "/upload/done", to: 'upload#uploadfile'
  match "/center_comparison", to: "statistics#center_comparison", :as => :center_comparison
  match "/center_comparison/show_graphic", to: "statistics#show_graphic", :as => :show_graphic
  match "/room_comparison_one", to: "statistics#room_comparison_one", :as => :room_comparison_one

  match "/update_rooms", to: "statistics#update_rooms"
  match "/show_graphic_one", to: "statistics#show_graphic_one", :as => :show_graphic_one
  match "/show_graphic_two", to: "statistics#show_graphic_two", :as => :show_graphic_two
end