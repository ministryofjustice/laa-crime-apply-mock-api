class CreateMaatApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :maat_applications do |t|
      #t.string :schemas
      #t.string :id
      # t.string :title
      # t.string :description
      # t.integer :id, :options => 'PRIMARY KEY'
      t.string :maat_id
      t.float :schema_version
      t.integer :reference
      t.string :application_type
      t.timestamp :submitted_at
      t.timestamp :declaration_signed_at
      t.timestamp :date_stamp
      t.timestamps
    end
  end
end
