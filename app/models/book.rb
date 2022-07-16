class Book < ApplicationRecord
  scope :price_desc, ->{order(price: :desc)}
  scope :latest_book, ->{order(created_at: :desc)}
  scope :by_ids, ->(ids){where id: ids}
end
