class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :books
  has_many :bookmarks, depandent: :destroy
  has_many :comments, depandent: :destroy
  has_many :goods, depandent: :destroy
end
