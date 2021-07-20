class AddIndex < ActiveRecord::Migration[6.1]
  def change
    add_index :missions, :title
    add_index :missions, :description
    add_index :missions, :status
  end
end
