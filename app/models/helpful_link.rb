class HelpfulLink < ApplicationRecord
  default_scope -> { order(name: :asc) }
  validates :url, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
