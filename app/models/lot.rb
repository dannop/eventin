class Lot < ApplicationRecord
  belongs_to :event
  
  validates :price, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 1000 }
  validates :ticket_total, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 1000,  only_integer: true }
  validates :ticket_current, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 1000,  only_integer: true }
  
  def self.available
    Lot.find_by(purchasable: true)
  end
end
