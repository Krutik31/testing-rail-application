class Product < ApplicationRecord
  belongs_to :user

  validates :product_name, presence: true, length: { in: 2..20 }
  validates :price, presence: true, comparison: { greater_than: 0 }
  validates :description, presence: true, length: { in: 10..200 }
end
