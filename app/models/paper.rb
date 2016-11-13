class Paper < ActiveRecord::Base
  belongs_to :authors

  validates :title, :venue, presence: true
end
