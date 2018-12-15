class Hotel < ApplicationRecord
    belongs_to :event
    has_many :rooms, dependent: :destroy
    
    mount_uploader :photo, PictureUploader
    
    validate :photo_size
  
    private
  
    def photo_size
        if photo.size > 2.megabytes
            errors.add(:photo, "Imagem não pode ter mais de 2 magabytes")
        end
    end
end
