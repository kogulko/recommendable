class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre

  has_many :reviews
  has_many :ratings

  validates :title, uniqueness: true
end
