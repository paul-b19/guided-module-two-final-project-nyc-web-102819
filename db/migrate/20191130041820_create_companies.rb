class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :description
      t.string :country_code
      t.string :time_zone_offset
      t.string :work_days
      t.string :open_time
      t.string :close_time

      t.timestamps
    end
  end
end
