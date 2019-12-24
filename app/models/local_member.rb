class LocalMember < ApplicationRecord
  belongs_to :idea
  belongs_to :member

  validates :amount, presence: true
  validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates_uniqueness_of :member_id, scope: :idea_id
end
