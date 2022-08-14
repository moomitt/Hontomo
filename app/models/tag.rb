class Tag < ApplicationRecord
  has_many :book_tags, dependent: :destroy
end
