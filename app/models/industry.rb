class Industry < ApplicationRecord
  has_many :ideas, through: :local_industries
end
