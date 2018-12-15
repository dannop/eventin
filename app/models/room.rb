class Room < ApplicationRecord
    belongs_to :hotel
    has_many :users, dependent: :nullify
    
    mount_uploader :photo, PictureUploader
    
    validates :number, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 10000,  only_integer: true }
    
    validate :photo_size
  
    private
  
    def photo_size
        if photo.size > 2.megabytes
            errors.add(:photo, "Imagem não pode ter mais de 2 magabytes")
        end
    end
end
