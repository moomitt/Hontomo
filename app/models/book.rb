class Book < ApplicationRecord
  belongs_to :user
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags, dependent: :destroy  #中間テーブルを介してTagテーブルへの関連付け
  
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image
end
