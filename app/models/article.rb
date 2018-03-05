class Article < ApplicationRecord
  belongs_to :user
  has_many :categorizations, dependent: :destroy
  has_many :categories, :through => :categorizations
  validates :user_id, presence: true
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true
  validate :has_category
  
  include PgSearch
  pg_search_scope :search, against: [:title, :content],
                  using: {tsearch: {dictionary: "english"},
                          trigram: {}
                         }
  
  def self.text_search(query)
    if query.present?
      search(query)
    else
      @articles = Article.all
    end
  end
  
  # Checks if article has it's Category set to internal.
  def has_category?(name)
    categories.exists?(name: name)
  end

  def internal?
    has_category?("Internal")
  end
  
  def has_category
    errors.add(:base, 'There must be at least one Category') if self.categories.empty?
  end
end