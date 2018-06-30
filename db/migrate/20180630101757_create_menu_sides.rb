class CreateMenuSides < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_sides do |t|
      t.references :sides_group, foreign_key: true
      t.references :menu_item, foreign_key: true

      t.timestamps
    end
  end
end
