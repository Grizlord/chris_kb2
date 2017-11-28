class AddInternalTo < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :internal, :boolean, default: false
  end
end
