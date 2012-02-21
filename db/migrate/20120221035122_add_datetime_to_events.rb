class AddDatetimeToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :date_time, :datetime
  end
end
