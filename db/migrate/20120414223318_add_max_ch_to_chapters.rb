class AddMaxChToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :maxlesson, :integer

  end
end
