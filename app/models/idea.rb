class Idea < ApplicationRecord
  validates :name, length: { minimum: 4 }
  validates :plan, plan: true
  validates :description, description: true
end
