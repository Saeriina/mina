class Product < ApplicationRecord
  validates :product_name, presence: true, length: { maximum: 255 }
  validates :diagnosis, presence: true, length: { maximum: 255 }
  validates :product_number, presence: true, length: { maximum: 255 }

  has_many :prescriptions
  belongs_to :user
end
