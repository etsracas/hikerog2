class CreateYamalogs < ActiveRecord::Migration
  def change
    create_table :yamalogs do |t|
      t.integer :user_id
      t.date :yama_date,    null: false
      t.string :yama_name,  null: false
      t.string :weather,    null: false
      t.string :member,     null: false
      t.text :route,        null: false
      t.text :yamalog_pic1
      t.text :gpslog

      t.timestamps null: false
    end

    add_index :yamalogs, [:user_id, :yama_name]
  end
end
