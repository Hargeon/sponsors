class LocalMember < ApplicationRecord
  belongs_to :idea
  belongs_to :member

  validates :amount, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 0 }
end
