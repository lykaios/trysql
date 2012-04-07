class CreateUserlessons < ActiveRecord::Migration
  def change
    create_table :userlessons do |t|
      t.integer :completed_ch
      t.integer :uid

      t.timestamps
    end
  end
end
