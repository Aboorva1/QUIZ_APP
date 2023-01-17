class AddSubCategoryToQuizzes < ActiveRecord::Migration[6.1]
  def change
    add_reference :quizzes, :sub_category, index: true 
  end
end
