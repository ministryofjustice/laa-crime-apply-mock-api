class CreateCrimeApplications < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'citext'

    create_table :crime_applications, id: :uuid do |t|

      t.jsonb :submitted_application
      t.string :status, null: false, default: 'submitted', index: true
      t.timestamp :submitted_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamp :returned_at
      t.timestamp :reviewed_at
      t.string :review_status, null: false, default: Types::ReviewApplicationStatus['application_received']
      t.virtual(
        :reference,
        type: :integer, as: "(submitted_application->>'reference')::int", stored: true
      )

      t.virtual(
        :applicant_first_name,
        type: :citext, as: "(submitted_application#>>'{client_details,applicant,first_name}')", stored: true
      )

      t.virtual(
        :applicant_last_name,
        type: :citext, as: "(submitted_application#>>'{client_details,applicant,last_name}')", stored: true
      )

      t.virtual(
        :office_code,
        type: :string, as: "(submitted_application->'provider_details'->>'office_code')", stored: true
      )

      t.virtual(
        :searchable_text,
        type: :tsvector, as: "to_tsvector('english', submitted_application#>>'{client_details,applicant,first_name}') || \
     to_tsvector('english', submitted_application#>>'{client_details,applicant,last_name}') || \
     to_tsvector('english', submitted_application->>'reference')", stored: true
      )

      t.string :offence_class
      t.jsonb :return_details

      t.timestamps
    end

    add_index :crime_applications, :searchable_text, using: :gin
    add_index :crime_applications, [:status, :submitted_at], order: { submitted_at: :desc}
    add_index :crime_applications, [:status, :returned_at], order: { returned_at: :desc}
    add_index :crime_applications, [:status, :reviewed_at], order: { reviewed_at: :desc}
    add_index :crime_applications, :reference
    add_index :crime_applications, [:applicant_last_name, :applicant_first_name], name: 'index_crime_applications_on_applicant_name'
    add_index :crime_applications, [:review_status, :submitted_at]
    add_index :crime_applications, [:review_status, :reviewed_at]
  end
end
