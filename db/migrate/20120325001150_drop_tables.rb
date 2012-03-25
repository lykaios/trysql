class DropTables < ActiveRecord::Migration
  def up
	  drop_table :course_fcts
	  drop_table :courses
	  drop_table :teachers
	  drop_table :students
  end

  def down
  end
end
