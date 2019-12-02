class Event < ApplicationRecord
  belongs_to :calendar
  belongs_to :company
end