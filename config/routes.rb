Rails.application.routes.draw do
  post 'user_quizzes/user_quiz_page'
  post 'user_quizzes/quiz_user_page'
  post 'user_quizzes/submit_quiz'
  devise_for :users, controllers: { registrations: "registrations" }
  
  root "quizzes#index"
  resources :quizzes do 
    resources :questions do
      resources :options do
        resources :user_answers
      end
    end
  end
  resources :categories
  resources :leader_board
  resources :user_quizzes do
    collection do
      get 'result'
      get 'my_quiz'
    end
  end  
  
end


