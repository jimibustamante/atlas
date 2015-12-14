class MiningWaste < ActiveRecord::Base
  belongs_to :labor
  belongs_to :region
  has_one :commune, through: :labor

  scope :no_activo, -> { where(status: "NO ACTIVO") }
  scope :activo, -> { where(status: "ACTIVO") }
  scope :abandonado, -> { where(status: "ABANDONADO") }
  scope :sin_info, -> { where(status: "S/I") }

  def coords
    return {latitude: self.lat, longitude: self.lon}
  end

  def commune_id
    labor.commune_id
  end

  def owner_name
    labor.owner.name
  end

  def labor_name
    labor.name
  end

  def formated_resolution_date
    if resolution_date.nil?
      "S/I"
    else
      resolution_date.strftime("%d/%m/%Y")
    end
  end

  def formated_resolution
    if resolution.nil?
      "S/I"
    else
      resolution
    end
  end

  def formated_resolution_closure_number
    if resolution_closure_number.nil?
      "S/I"
    else
      resolution_closure_number
    end
  end

  def formated_resolution_closure_date
    if resolution_closure_date.nil?
      "S/I"
    else
      resolution_closure_date.strftime("%d/%m/%Y")
    end
  end

  def formated_utm_north
    utm_formated(utm_north)    
  end

  def formated_utm_east
    utm_formated(utm_east)    
  end

  def formated_partial_ton
    if partial_ton.nil?
      "S/I"
    else
      number_format(partial_ton)
    end
  end

  def formated_total_ton
    if total_ton.nil?
      "S/I"
    else
      number_format(total_ton)
    end
  end

  def formated_partial_volume
    if partial_volume.nil?
      "S/I"
    else
      number_format(partial_volume)
    end
  end

  def formated_total_volume
    if total_volume.nil?
      "S/I"
    else
      number_format(total_volume)
    end
  end

  def number_format(val)
    val.split(".").first.gsub(",",".")
  end

  def utm_formated(utm)
    utm.split(".").first.gsub(",",".")
  end

end
