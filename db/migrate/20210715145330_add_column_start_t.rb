class AddColumnStartT < ActiveRecord::Migration[6.1]
  def change
    add_column :missions, :start_time, :datetime
    add_column :missions, :end_time, :datetime
  end
end
