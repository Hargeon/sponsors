class LocalMember < ApplicationRecord
  belongs_to :idea
  belongs_to :member

  validates :amount, numericality: { only_integer: true }
end
