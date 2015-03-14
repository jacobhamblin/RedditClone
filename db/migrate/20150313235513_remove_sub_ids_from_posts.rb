class RemoveSubIdsFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :sub_ids
  end
end
