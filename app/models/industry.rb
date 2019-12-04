class Industry < ApplicationRecord
  has_many :local_industries
  has_many :ideas, through: :local_industries
end
