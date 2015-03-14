class ChangeSubIds < ActiveRecord::Migration
  def change
    remove_column :posts, :sub_id
    add_column :posts, :sub_ids, :string, default: "", null: false
    add_index :posts, :sub_ids
  end
end
