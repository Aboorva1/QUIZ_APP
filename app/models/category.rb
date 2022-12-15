class Category < ApplicationRecord
    has_many :sub_categories, :dependent => :destroy
    validates :title, presence: true
    validates_format_of :title, :with => /\A([a-zA-Z]+\s)*[a-zA-Z]+\z/
end
