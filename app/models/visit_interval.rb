class VisitInterval < ApplicationRecord
  validates :interval, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 360 }
 
  belongs_to :clinic
  belongs_to :user
end
