class Prescription < ApplicationRecord
  validates :quantity, presence: true
  validates :ratio, presence: true, length: { maximum: 255 }

  belongs_to :product
  belongs_to :clinic
end
