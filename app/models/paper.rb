class Paper < ActiveRecord::Base
  belongs_to :authors

  validates :title, presence: true
end
