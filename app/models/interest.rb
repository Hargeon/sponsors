class Interest < ApplicationRecord
  belongs_to :idea
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :idea_id
end
