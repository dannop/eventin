class Workshop < ApplicationRecord
  belongs_to :event
  belongs_to :category, optional: true
  
  has_many :archives, dependent: :destroy
  has_many :work_users, dependent: :destroy
  has_many :work_staffs, dependent: :destroy
  
  validates :title, presence: true, uniqueness: true, length: {in: 2..40}
  validates :description, presence: true, length: {in: 2..300}
  validates :vacancies, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 1000,  only_integer: true }
  
end
