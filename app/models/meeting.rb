class Meeting < ApplicationRecord
  belongs_to :calendar
  belongs_to :company

  self.inheritance_column = :type

  def self.types
    %w(Holiday Private Shared)
  end

  scope :holidays, -> { where(type: 'Holiday') } 
  scope :privates, -> { where(type: 'Private') } 
  scope :shareds, -> { where(type: 'Shared') }

end
