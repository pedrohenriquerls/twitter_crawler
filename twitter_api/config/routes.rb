Rails.application.routes.draw do
  post 'tweets' => 'tweets#create'
end
