class CreateCourses < ActiveRecord::Migration
  def change
    drop_table :courses
    create_table :courses do |t|
      t.string :dept
      t.integer :cnum
      t.integer :id
      t.string :desc

      t.timestamps
    end
  end
end
