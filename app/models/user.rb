class User < ApplicationRecord
  authenticates_with_sorcery!

  def oauth_user?
    provider.present? && uid.present?
  end

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }, unless: :oauth_user?
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }, unless: :oauth_user?
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }, unless: :oauth_user?
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true

  has_many :clinics, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :submissions, dependent: :destroy

  def own?(object)
    id == object&.user_id
  end

  def self.find_or_create_from_google(auth)
    user = find_or_initialize_by(email: auth['info']['email'])

    if user.new_record?
      user.name = auth['info']['name']
      user.uid = auth['uid']
      user.provider = 'google'
      user.save!
    end
    user
  end

end
