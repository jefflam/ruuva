class RemoveDateTimeFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :date, :integer
  	remove_column :events, :time, :integer	
  end

  def down
  	add :events, :date, :integer
  	add :events, :time, :integer  	
  end
end
