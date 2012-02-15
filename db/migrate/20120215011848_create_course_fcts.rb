class CreateCourseFcts < ActiveRecord::Migration
  def change
    create_table :course_fcts do |t|
      t.integer :year
      t.string :semester
      t.references :teacher
      t.references :course
      t.references :student
      t.timestamps
    end
  end
end
