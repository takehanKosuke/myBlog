class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.text    :title
      t.text    :text
      t.integer :user_id


      t.timestamps null: false
    end
  end
end
