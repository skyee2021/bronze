class AddColUserMission < ActiveRecord::Migration[6.1]
  def change
    add_reference(:missions, :user, null: false, default: 3)
  end
end
