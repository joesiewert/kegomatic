class Keg < ActiveRecord::Base
  validates :name, uniqueness: true

  def pretty_price
    "$#{price}"
  end

  def pretty_sale_price
    "$#{sale_price}"
  end
end
