class CreateInterestsOfJustices < ActiveRecord::Migration[7.0]
  def change
    create_table :interests_of_justices do |t|

      t.bigint :maat_application_id
      t.string :ioj_type # Deviates from the schema name of "type" as "type" is reserved
      t.string :reason
      t.timestamps
    end

    add_foreign_key :interests_of_justices, :maat_applications
  end
end
