class Archive < ApplicationRecord
  belongs_to :lecture, optional: true
  belongs_to :workshop, optional: true
  
  mount_uploader :attachment, AttachmentUploader
  validates :name, presence: true, length: {in: 2..30}
  validates :description, presence: true, length: {in: 1..300}
  validate :attachment_size
  
  
  private
  def attachment_size
    if attachment.size > 2.megabytes
      errors.add(:attachment,  "Imagem não pode ter mais de 2 magabytes")
    end
  end
end
