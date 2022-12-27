class Question < ApplicationRecord
	belongs_to :quiz
  has_many :options, dependent: :destroy
  has_many :user_answers, dependent: :destroy

  accepts_nested_attributes_for :options, allow_destroy: true

  validates :body, presence: true
  validate :uniqueness_of_options
 
  private
 
  def uniqueness_of_options
    errors.add(:options, 'must be unique') if options.map(&:choice).uniq.size != options.size
  end
  
end
