class Industry < ApplicationRecord
  has_many :company_industries
  has_many :company, through: :company_industries
end
