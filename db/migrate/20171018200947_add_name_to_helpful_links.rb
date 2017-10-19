class AddNameToHelpfulLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :helpful_links, :name, :string
  end
end
