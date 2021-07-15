class AddMissionColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :missions, :status, :integer, default: 0
    
  end
end
