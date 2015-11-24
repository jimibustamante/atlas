class Owner < ActiveRecord::Base
  has_many :labors

  def mining_wastes
    labors.map(&:mining_wastes).flatten
  end
end
