class CreateCategorizations < ActiveRecord::Migration[5.1]
  def change
    create_table :categorizations do |t|
      t.integer :article_id
      t.integer :category_id

      t.timestamps
    end
  end
end
