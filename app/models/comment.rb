class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :goods, depandent: :destroy
end
