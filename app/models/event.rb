class Event < ApplicationRecord
  has_many :lectures, dependent: :destroy
  has_many :workshops, dependent: :destroy
  has_many :hotels, dependent: :destroy
  has_many :staffs, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true, length: {in: 2..25}
  validates :description, presence: true, length: {in: 1..300}
  
end
