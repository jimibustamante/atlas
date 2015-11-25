class MiningWaste < ActiveRecord::Base
  belongs_to :labor
  belongs_to :region
  has_one :commune, through: :labor

  scope :activo, -> { where(status: "ACTIVO") }
  scope :no_activo, -> { where(status: "NO ACTIVO") }
  scope :abandonado, -> { where(status: "ABANDONADO") }
  scope :sin_info, -> { where(status: "S/I") }

  def coords
    return {latitude: self.lat, longitude: self.lon}
  end
end
