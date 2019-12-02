class CreateTimezones < ActiveRecord::Migration[6.0]
  def change
    create_table :timezones do |t|
      t.string :code
      t.string :name
      t.string :zone
      t.string :offset
    end
  end
end
