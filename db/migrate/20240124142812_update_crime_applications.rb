class UpdateCrimeApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :crime_applications, :work_stream, :string, null: false, default: 'criminal_applications_team'
    add_column(
      :crime_applications,
      :return_reason,
      :virtual,
      as: "(return_details->>'reason')",
      type: :string,
      stored: true
    )
    add_column(
      :crime_applications,
      :case_type,
      :virtual,
      as: "(submitted_application->'case_details'->>'case_type')",
      type: :string,
      stored: true
    )

    add_index :crime_applications, :work_stream
    add_index :crime_applications, :return_reason
    add_index :crime_applications, :office_code
    add_index :crime_applications, :case_type
  end
end
