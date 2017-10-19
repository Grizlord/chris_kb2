class CreateHelpfulLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :helpful_links do |t|
      t.string :url

      t.timestamps
    end
  end
end
