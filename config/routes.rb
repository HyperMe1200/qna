Rails.application.routes.draw do
  devise_for :users

  concern :votable do
    member do
      post 'vote_up'
      post 'vote_down'
      delete 'cancel_vote'
    end
  end

  resources :questions do
    resources :answers, shallow: true do
      patch :best, on: :member
      concerns :votable
    end
    concerns :votable
  end

  resources :attachments, only: :destroy

  root 'questions#index'
end
