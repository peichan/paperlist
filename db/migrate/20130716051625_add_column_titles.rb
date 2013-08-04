class AddColumnTitles < ActiveRecord::Migration
  def up
    change_column :papers, :publicationYear, :integer
  end

  def down
    change_column :papers, :publicationYear, :string
  end
end
