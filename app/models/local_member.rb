class LocalMember < ApplicationRecord
  belongs_to :idea
  belongs_to :member

  MINIMUM_AMOUNT = 0

  validates :amount, presence: true
  validates :amount, numericality: { only_integer: true }
  validates :amount, numericality: { greater_than_or_equal_to: MINIMUM_AMOUNT }
  validates_uniqueness_of :member_id, scope: :idea_id
end
