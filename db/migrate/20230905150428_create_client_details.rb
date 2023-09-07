class CreateClientDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :client_details do |t|

      t.bigint :maat_application_id
      t.timestamps
    end

    add_foreign_key :client_details, :maat_applications
  end
end
