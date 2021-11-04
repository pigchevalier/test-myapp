class CreateUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :urls do |t|
      t.string :longurl
      t.string :shorturl
      t.integer :count

      t.timestamps
    end
  end
end
