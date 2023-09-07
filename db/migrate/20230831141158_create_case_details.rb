class CreateCaseDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :case_details do |t|

      t.bigint :maat_application_id
      t.string :urn
      t.string :case_type
      t.string :appeal_maat_id
      t.timestamp :appeal_lodged_date
      t.string :appeal_with_changes_details
      t.string :offence_class
      t.string :hearing_court_name
      t.timestamp :hearing_date
      t.timestamps
    end

    add_foreign_key :case_details, :maat_applications
  end
end
