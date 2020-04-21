Rails.application.routes.draw do
  devise_for :api_users
  post "/graphql", to: "graphql#execute"
  devise_for :users
end
