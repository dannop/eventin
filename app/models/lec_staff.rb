class LecStaff < ApplicationRecord
  belongs_to :staff
  belongs_to :lecture
  
  validate :dual_relationship
  validate :many_relationships
  
  
  private
  def dual_relationship
    if LecStaff.find_by(staff_id: staff_id, lecture_id: lecture_id)
      errors.add(:staff_id, "O membro já está designado para a palestra.")
    end
  end
  
  def many_relationships
    if LecStaff.where(lecture_id: lecture_id).count > 12
      errors.add(:lecture_id, "Limite de palestrantes atingido.")
    end
  end
end
