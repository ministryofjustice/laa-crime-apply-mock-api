class CreateApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :applicants do |t|

      t.bigint :client_detail_id
      t.string :first_name
      t.string :last_name
      t.string :other_names
      t.date :date_of_birth
      t.string :nino
      t.string :telephone_number
      t.string :correspondence_address_type
      # t.bigint :home_address_id
      t.references :home_address, foreign_key: { to_table: 'addresses' }
      t.references :correspondence_address, foreign_key: { to_table: 'addresses' }
      t.timestamps
    end

    add_foreign_key :applicants, :client_details
  end
end
