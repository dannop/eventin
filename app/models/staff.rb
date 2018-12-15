class Staff < ApplicationRecord
    belongs_to :event
    has_many :lec_staffs
    has_many :work_staffs
    
    mount_uploader :photo, PictureUploader
    
    validates :name, presence: true, length: {in: 2..30}
    validates :job, presence: true, length: {in: 2..25}
    validates :age, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100,  only_integer: true }
    validates :description, presence: true, length: {in: 2..300}
    
    validate :photo_size
  
    private
  
    def photo_size
        if photo.size > 2.megabytes
            errors.add(:photo, "Imagem não pode ter mais de 2 magabytes")
        end
    end
end
