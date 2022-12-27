Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  root "quizzes#index"
  get 'home/user_board'
  get 'leader_board/category'
  resources :home 
  resources :quizzes do 
    resources :questions do
      resources :options do
        resources :user_answers
      end
    end
  end
  resources :categories
  resources :sub_categories
  resources :leader_board
  resources :user_quizzes do
    collection do
      get 'start'
      get 'result'
      get 'my_quiz'
      post 'user_quiz_page'
      post 'save_answer'
      post 'submit_quiz'
    end
  end  
  
end


