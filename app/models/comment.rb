class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :goods, dependent: :destroy
  
  def gooded_by?(user)
    goods.exists?(user_id: user.id)
  end
  
  validates :text, presence: true, length: { maximum: 100 }
end
