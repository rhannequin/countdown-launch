Countdown::Application.routes.draw do

  match :admin,                :to => 'admin#index',        :as => :admin
  get   '/admin/login',        :to => 'admin#login',        :as => :admin_login
  post  '/admin/authenticate', :to => 'admin#authenticate', :as => :admin_authenticate

  post  '/create',      :to => 'ctdowns#create',  :as => :ctdowns
  get  '/destroy/:id', :to => 'admin#destroy', :as => :ctdown_destroy
  match ':slug'             => 'ctdowns#show',    :as => :ctdown


  root :to => 'ctdowns#new'

end
