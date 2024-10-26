class CreateBugs < ActiveRecord::Migration[7.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.integer :category
      t.integer :status
      t.datetime :deadline
      t.string :screenshot
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :developer_id

      t.timestamps
    end
  end
end
