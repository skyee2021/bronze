class ChangeMissionCol < ActiveRecord::Migration[6.1]
  def change
    change_column :missions, :title, :string, null: false
    change_column :missions, :start_time, :datetime, null: false
    change_column :missions, :end_time, :datetime, null: false
  end
end
