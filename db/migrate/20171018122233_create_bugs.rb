class CreateBugs < ActiveRecord::Migration[5.0]
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.date :deadline
      t.integer :bug_type
      t.string :status
      t.attachment :screen_shot
      t.references :creator, index: true
      t.references :project, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
