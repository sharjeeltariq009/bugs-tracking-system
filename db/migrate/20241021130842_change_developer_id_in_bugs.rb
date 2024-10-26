class ChangeDeveloperIdInBugs < ActiveRecord::Migration[7.2]
  def change
        change_column_null :bugs, :developer_id, true # This makes developer_id optional (nullable)

  end
end
