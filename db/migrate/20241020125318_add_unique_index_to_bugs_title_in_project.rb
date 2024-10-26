class AddUniqueIndexToBugsTitleInProject < ActiveRecord::Migration[7.2]
  def change
    add_index :bugs, [:title, :project_id], unique: true
  end
end
