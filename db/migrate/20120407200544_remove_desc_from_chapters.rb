class RemoveDescFromChapters < ActiveRecord::Migration
  def up
    remove_column :chapters, :ch
	remove_column :chapters, :desc
	add_column :chapters, :description, :string
  end

  def down
    add_column :chapters, :ch, :integer
  end
end
