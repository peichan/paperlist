class CreateMylists < ActiveRecord::Migration
  def change
    create_table :mylists do |t|
      t.string :account
      t.string :title

      t.timestamps
    end
  end
end
