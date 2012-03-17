class CreateDbqs < ActiveRecord::Migration
  def change
    create_table :dbqs do |t|
      t.string :qtext

      t.timestamps
    end
  end
end
