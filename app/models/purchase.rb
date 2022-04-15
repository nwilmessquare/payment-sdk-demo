class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :catalog_item
end
