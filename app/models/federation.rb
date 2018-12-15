class Federation < ApplicationRecord
    has_many :ejs
    
    mount_uploader :icon, PictureUploader
    
    validates :name, presence: true, uniqueness: true, length: {in: 2..30}
    validates :state, presence: true
    validate :icon_size
  
    private
  
    def icon_size
        if icon.size > 2.megabytes
            errors.add(:icon, "Imagem não pode ter mais de 2 magabytes")
        end
    end
    
end
