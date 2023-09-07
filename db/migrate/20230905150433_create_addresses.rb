class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|

      t.string :lookup_id
      t.string :address_line_one
      t.string :address_line_two
      t.string :city
      t.string :country
      t.string :postcode
      t.timestamps
    end
  end
end
