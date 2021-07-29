class CreateTagLists < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_lists do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :mission, null: false, foreign_key: true

      t.timestamps
    end
  end
end
