class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :type
      t.string :title
      t.text :description
      t.integer :calendar_id
      t.integer :company_id
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
