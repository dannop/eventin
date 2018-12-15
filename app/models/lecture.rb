class Lecture < ApplicationRecord
  belongs_to :event
  belongs_to :category, optional: true
  
  has_many :archives, dependent: :destroy
  has_many :lec_users, dependent: :destroy
  has_many :lec_staffs, dependent: :destroy
  
  validates :title, presence: true, uniqueness: true, length: {in: 1..40}
  validates :description, presence: true, length: {in: 1..300}
  validates :vacancies, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 1000,  only_integer: true }
  
end