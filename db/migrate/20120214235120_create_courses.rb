class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :id
      t.string :dept
      t.integer :cnum
      t.string :title
      t.string :desc

      t.timestamps
    end
  end
end
