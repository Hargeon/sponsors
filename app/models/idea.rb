class Idea < ApplicationRecord
  validates :name, length: { minimum: 4 }
  validates :plan, size: true
  validates :description, size: true
end
