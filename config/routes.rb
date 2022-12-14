Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  
  root "quizzes#index"
  get 'home/userboard'
  resources :home 
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
      post 'user_quiz_page'
      post 'save_answer'
      post 'submit_quiz'
    end
  end  
  
end


