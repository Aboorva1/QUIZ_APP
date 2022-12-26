class LeaderBoardController < ApplicationController
  
  before_action :authenticate_user!

  def index
    add_breadcrumb("Leader Board")
    @user_quizzes = UserQuiz.order("score DESC, quiz_time ASC").where.not('score' => nil).first(10)
    @images = []
    @user_quizzes.each do |user_quiz|
      @images << UserQuiz.find_by(user_id: user_quiz.user_id).user.image
    end
  end

  def category
    average_list
  end

  def show 
    average_list
  end
  
  def average_list
    @categories = Category.all
    if !params[:id].present?
      @category = Category.last
    else
      @category = Category.find(params[:id])
    end
    add_breadcrumb(@category.title)
    users = UserQuiz.where(category_id: @category.id).distinct.pluck(:user_id)
    @average = []
    users.each do |user|
      user_quizzes = UserQuiz.order('quiz_id, created_at DESC').select('distinct on (quiz_id) *').where(category_id: @category.id, user_id: user)
      @average << {
        user: user,
        average: (user_quizzes.sum('score')/user_quizzes.count(:all)).to_i,
        count: user_quizzes.count(:all)
      }
    end
    @average.sort_by! {|average| [average[:count], average[:average]] }.reverse!
  end
end
