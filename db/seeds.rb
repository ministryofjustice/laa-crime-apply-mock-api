# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
path = 'db/data/crimeApplyDatastoreTestData.json'
data = File.read(path)
episodes = JSON.parse(data)
result = []
episodes.each do |hash|
  unless CrimeApplication.exists?(id: hash['submitted_application']['id'])
    crime_application = CrimeApplication.create!(submitted_application: hash['submitted_application'])
    # Manually setting this here, as it is an enum on the object that you don't seem to be able to set during creation
    crime_application.review_status = "ready_for_assessment"
    crime_application.save
  end
end

