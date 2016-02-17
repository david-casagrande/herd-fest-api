Rails.application.routes.draw do
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }, skip: [:sessions]
  as :admin do
    get 'admins/sign_in', to: 'devise/sessions#new', as: :new_admin_session
    delete 'admins/sign_out', to: 'devise/sessions#destroy', as: :destroy_admin_session
  end

  mount RailsAdmin::Engine => '/manage', as: 'rails_admin'

  namespace :api do
    resources :bands, only: [:index]
    resources :days, only: [:index]
    resources :venues, only: [:index]
    resources :set_times, only: [:index]
    resources :full_schedule, only: [:index]
  end

  root 'rails_admin/main#dashboard'
end
