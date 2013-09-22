class AddColumnMylists < ActiveRecord::Migration
  def up
    add_column :mylists, :comment, :text
  end

  def down
    remove_column :mylists, :comment, :text
  end
end
