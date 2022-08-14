class Book < ApplicationRecord
  belongs_to :user
  has_many :book_tags, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image
end
