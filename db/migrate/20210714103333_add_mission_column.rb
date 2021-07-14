class AddMissionColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :missions, :status, :string, default: "pending"
    add_column :missions, :tag, :string
    add_column :missions, :priority, :string
  end
end
