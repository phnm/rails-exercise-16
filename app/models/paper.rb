class Paper < ActiveRecord::Base
  has_and_belongs_to_many :authors

  validates :title, :venue, presence: true
  validates :year, numericality: { only_integer: true }
end
