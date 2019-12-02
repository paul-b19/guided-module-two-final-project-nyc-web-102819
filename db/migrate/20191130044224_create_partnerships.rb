class CreatePartnerships < ActiveRecord::Migration[6.0]
  def change
    create_table :partnerships do |t|
      t.integer :company_id
      t.integer :calendar_id

      t.timestamps
    end
  end
end
