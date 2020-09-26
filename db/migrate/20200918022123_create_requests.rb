class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :lang
      t.text :text
      t.text :response

      t.timestamps
    end
  end
end
