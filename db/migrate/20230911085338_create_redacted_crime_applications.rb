class CreateRedactedCrimeApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :redacted_crime_applications, id: :uuid do |t|

      t.references :crime_application, type: :uuid, foreign_key: true, null: true, index: { unique: true }
      t.jsonb :submitted_application, null: false, default: {}
      t.jsonb :metadata, null: false, default: {}
      t.virtual(
        :status,
        type: :string, as: "(metadata->>'status')", stored: true
      )

    end

    add_index :redacted_crime_applications, :status

  end
end
