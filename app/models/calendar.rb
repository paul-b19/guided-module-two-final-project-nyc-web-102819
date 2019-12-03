class Calendar < ApplicationRecord
  has_many :partnerships
  has_many :companies, through: :partnerships
  has_many :meetings
end