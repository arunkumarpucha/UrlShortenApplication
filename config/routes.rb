Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root  'mini_urls#new'

  post "/create_mini_url" => 'mini_urls#create'

  get "/show_mini_url/:id" => 'mini_urls#show'

  get "/stats" => 'mini_urls#index'

  post '/report_analytic' => 'mini_urls#report_analytic'


end
