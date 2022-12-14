class HomeController < ApplicationController
  def index
    @users = User.where.not(name: "Admin")
  end

  def userboard
    @user_quizzes = UserQuiz.where(user_id: params[:id])
    @user = User.find_by(id: params[:id])
  end

end
