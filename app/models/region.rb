class Region < ActiveRecord::Base
  has_many :provinces

  def comunnes
    # provinces.map()
  end
end
