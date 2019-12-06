class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.string :type
      t.string :name
      t.text :description
      t.integer :calendar_id
      t.integer :company_id
      t.datetime :start_time
      t.datetime :end_time
      t.string :country_code

      t.timestamps
    end
  end
end
