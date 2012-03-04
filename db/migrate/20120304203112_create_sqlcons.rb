class CreateSqlcons < ActiveRecord::Migration
  def change
    create_table :sqlcons do |t|
      t.integer :ch
      t.integer :sec
      t.text :regtext
      t.text :qtext

      t.timestamps
    end
  end
end
