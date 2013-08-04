class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
      t.string :title
      t.string :author
      t.string :url
      t.integer :startingPage
      t.integer :endingPage
      t.datetime :publicationDate
      t.string :publicationName

      t.timestamps
    end
  end
end
