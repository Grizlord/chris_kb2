class Category < ApplicationRecord
  has_many :articles, dependent: :destroy
  default_scope -> { order(name: :asc) }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  include PgSearch
  
  pg_search_scope :search, :associated_against => {
    :articles => [:title, :content],
     using: {tsearch: {dictionary: "english"},
            trigram: {},
            dmetaphone: {}
           }
    }
  
  def self.text_search(query)
    if query.present?
      search(query)
    else
      @articles = @category.articles.paginate(page: params[:page], :per_page => 10)
    end
  end
end
