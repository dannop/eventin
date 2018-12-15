class User < ApplicationRecord
  belongs_to :ej, optional: true
  belongs_to :room, optional: true
  
  has_many :asked_transfers, class_name: "TransferAsk", foreign_key: "replyer_id", dependent: :destroy
  has_many :replyed_transfers, class_name: "TransferAsk", foreign_key: "replyer_id", dependent: :destroy

  has_many :lec_users
  has_many :work_users
  
  before_create :confirmation_token
  
  mount_uploader :photo, PictureUploader
  has_secure_password
  
  validates :name, presence: true, length: {in: 2..25}
  validates :last_name, length: {in: 1..25, allow_nil: true}
  validates :password, length: {in: 3..50, presence: true, allow_nil: true}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {in: 3..50}, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  
  validate :picture_size
  
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def generate_password_reset_token!
    update_attribute(:password_reset_token, SecureRandom.urlsafe_base64(48))
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      if !user.email.present?
        user.email = (0...6).map { ('a'..'z').to_a[rand(26)] }.join+"@facebook.com" 
      end
      user.email_confirmed = true
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      password = Passgen::generate
      user.password = password
      user.password_confirmation = password
      user.save!
    end 
  end
  
  def confirmation_token
    if self.confirm_token.blank?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
  
  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  
  private
  
  def picture_size
    if photo.size > 2.megabytes
      errors.add(:photo, "Imagem não pode ter mais de 2 magabytes")
    end
  end

end
