class Tag < ApplicationRecord
  has_many :book_tags, dependent: :destroy
  has_many :books, through: :book_tags, dependent: :destroy  #中間テーブルを介してBookテーブルへの関連付け
  
  validates :series, length: { minimum: 1, maximum: 12 }, uniqueness: true
end
