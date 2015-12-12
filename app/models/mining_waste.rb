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

  def popup_url
    return '/templates/popover.html'
  end

  def formated_resolution_date
    if resolution_date.nil?
      "S/I"
    else
      resolution_date.strftime("%d/%m/%Y")
    end
  end

  def formated_resolution_closure_date
    if resolution_closure_date.nil?
      "S/I"
    else
      resolution_closure_date.strftime("%d/%m/%Y")
    end
  end

end
