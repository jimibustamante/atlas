class Labor < ActiveRecord::Base
  belongs_to :commune
  belongs_to :owner
  has_many :mining_wastes
end
