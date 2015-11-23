class Region < ActiveRecord::Base
  has_many :provinces
  has_many :mining_wastes

  def communes
    provinces.map(&:communes).flatten
  end
end
