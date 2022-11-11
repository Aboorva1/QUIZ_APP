Rails.application.routes.draw do
  
  get 'answer/create_answers'
  post 'answer/create_answers'
  get 'answer/result'
  get 'answer/myquiz'
  devise_for :users, controllers: { registrations: "registrations" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'home#index'

  # resources :quizzes
  # get '/quizzes/:id/leaderboard' => "quizzes#leaderboard"
  # post '/quizzes/:id' => "quizzes#check_answer"

  # get '/home/leaderboard' => "home#user_board"

  root "quizzes#index"
  resources :quizzes do 
    resources :questions do
      resources :options do
        resources :user_answers
      end
    end
  end
end



