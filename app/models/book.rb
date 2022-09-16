class Book < ApplicationRecord
  belongs_to :user
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags, dependent: :destroy  #中間テーブルを介してTagテーブルへの関連付け
  
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image
  
  def bookmarked_by?(user)                 #すでにブックマークしているか検証
    bookmarks.where(user_id: user).exists?
  end
  
  validates :series, length: { minimum: 2, maximum: 20 }
end
