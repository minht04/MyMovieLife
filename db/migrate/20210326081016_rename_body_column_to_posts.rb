class RenameBodyColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :body, :details
  end
end
