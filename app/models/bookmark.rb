class Bookmark < ApplicationRecord
  belongs_to :book
  belongs_to :user
  
  validates :user_id, uniqueness: { scope: :book_id }  # ロード中の重複登録を防ぐ
end
