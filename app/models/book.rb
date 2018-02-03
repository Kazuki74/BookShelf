class Book < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :author, length: { maximum: 255 }
  has_and_belongs_to_many :categories
end