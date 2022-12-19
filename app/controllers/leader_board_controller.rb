class LeaderBoardController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @user_quizzes = UserQuiz.order("score DESC, quiz_time ASC").first(10)
    @images = []
    @user_quizzes.each do |user_quiz|
      @images << UserQuiz.find_by(user_id: user_quiz.user_id).user.image
    end
  end

  def category
    @categories = Category.all
  end

end
