class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true
  
  include PgSearch
  pg_search_scope :search, against: [:title, :content],
    using: {tsearch: {dictionary: "english"}}
  
  def self.text_search(query)
    if query.present?
      search(query)
    else
      @articles = Article.all
    end
  end
end
