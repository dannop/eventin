class WorkStaff < ApplicationRecord
  belongs_to :staff
  belongs_to :workshop
  validate :dual_relationship
  validate :many_relationships
  
  
  private
  def dual_relationship
    if WorkStaff.find_by(staff_id: staff_id, workshop_id: workshop_id)
      errors.add(:staff_id, "O membro já está designado para a palestra.")
    end
  end
  
  def many_relationships
    if WorkStaff.where(workshop_id: workshop_id).count > 12
      errors.add(:workshop_id, "Limite de palestrantes atingido.")
    end
  end
end
