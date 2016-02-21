class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.string :username
      t.string :key
      t.datetime :date
      t.timestamps null: false
    end
  end
end
