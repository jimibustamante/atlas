class MiningWaste < ActiveRecord::Base
  belongs_to :labor
  belongs_to :region
  has_one :commune, through: :labor

  def coords
    return {latitude: self.lat, longitude: self.lon}
  end
end
