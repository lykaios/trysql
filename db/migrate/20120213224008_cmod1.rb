class Cmod1 < ActiveRecord::Migration
  def up
    change_table :courses do |t|
      t.remove :name, :id
	  t.integer :cnum
	  t.integer :id
	  t.index :id
    end
  end

end
