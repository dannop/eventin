class Category < ApplicationRecord
    has_many :lectures, dependent: :nullify
    has_many :workshops, dependent: :nullify
    
    
    validates :kind, presence: true, length: {in: 2..20}, uniqueness: true
end