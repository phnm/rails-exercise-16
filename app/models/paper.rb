class Paper < ActiveRecord::Base
  belongs_to :authors

  validates :title, :venue, presence: true
  validates :year, numericality: { only_integer: true }
end
