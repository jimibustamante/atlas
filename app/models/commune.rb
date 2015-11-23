class Commune < ActiveRecord::Base
  belongs_to :province
  has_many :labors
  has_many :mining_wastes, through: :labors
end
