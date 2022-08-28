class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :goods, dependent: :destroy
end
