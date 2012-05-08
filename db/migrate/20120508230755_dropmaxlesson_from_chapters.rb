class DropmaxlessonFromChapters < ActiveRecord::Migration
  def up
  	remove_column :chapters, :maxlesson
  end

  def down
  end
end
