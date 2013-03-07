Countdown::Application.routes.draw do

  post  '/create', :to => 'ctdowns#create', :as => :ctdowns
  match ':slug'        => 'ctdowns#show',   :as => :ctdown

  root :to => 'ctdowns#new'

end
