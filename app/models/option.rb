class Option < ApplicationRecord
    belongs_to :question
    validates :option1, presence: true
    has_many :user_answers, dependent: :destroy
    before_save :falsify_all_others
    def falsify_all_others
      if correct_key
        self.class.where('id != ?', self.id).where('correct_key').update_all(:correct_key => true)
      end
    end   
end



