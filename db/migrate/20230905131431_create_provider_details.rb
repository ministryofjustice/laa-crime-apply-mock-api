class CreateProviderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :provider_details do |t|

      t.bigint :maat_application_id
      t.string :office_code
      t.string :provider_email
      t.string :legal_rep_first_name
      t.string :legal_rep_last_name
      t.string :legal_rep_telephone
      t.timestamps
    end

    add_foreign_key :provider_details, :maat_applications
  end
end
