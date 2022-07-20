class Book < ApplicationRecord
  has_many :comments, dependent: :destroy

  scope :price_desc, ->{order(price: :desc)}
  scope :latest_book, ->{order(created_at: :desc)}
  scope :by_ids, ->(ids){where id: ids}
  
  def getRating
    rating = 0
    amountofcomments = 0
    Comment.all.each do |comment|
      if comment.book_id == self.id
        rating += comment.num_star
        amountofcomments = amountofcomments + 1
      end
    end
    if amountofcomments == 0 then amountofcomments = 1 end
    rating = (rating / amountofcomments).round(1)
  end
  scope :search, ->(key){where("name LIKE ? or description LIKE ?", "%#{key}%", "%#{key}%")}
end
