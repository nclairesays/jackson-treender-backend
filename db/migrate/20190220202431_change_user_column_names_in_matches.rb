class ChangeUserColumnNamesInMatches < ActiveRecord::Migration[5.2]
  def change
    rename_column :matches, :user1, :user1_id
    rename_column :matches, :user2, :user2_id
  end
end
