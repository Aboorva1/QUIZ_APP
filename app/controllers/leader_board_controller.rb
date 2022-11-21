class LeaderBoardController < ApplicationController

  def index
    @user_quizzes = UserQuiz.order("score DESC, created_at DESC").first(10)
    @images = []
    @user_quizzes.each do |user_quiz|
      @images << UserQuiz.find_by(user_id: user_quiz.user_id).user.image
    end
  end

end
