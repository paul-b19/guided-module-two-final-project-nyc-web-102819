class Company < ApplicationRecord
  has_many :partnerships
  has_many :calendars, through: :partnerships
  has_many :meetings
end