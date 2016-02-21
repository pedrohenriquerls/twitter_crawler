Rails.application.routes.draw do
  post 'tweets' => 'tweets#create'
  get  'tweets' => 'tweets#list_all'
end
