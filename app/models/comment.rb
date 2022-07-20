class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_one_attached :image
  validates :content, presence: true, length: { maximum: 140 }
  validates :num_star, presence: true
  scope :latest_comment, ->{order(created_at: :desc)}
  scope :by_book_id, ->(book_id){where(book_id: book_id)}

  validates :image, content_type: { in: %w[image/jpeg image/gif image/png], message: "must be a valid image format" },
            size: { less_than: 5.megabytes, message: "should be less than 5MB" }

  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
