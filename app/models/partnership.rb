class Partnership < ApplicationRecord
  belongs_to :company
  belongs_to :calendar
end