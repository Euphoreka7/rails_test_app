# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ClientSetting.delete_all
Client.delete_all
ExperimentOption.delete_all
Experiment.delete_all

experiment = Experiment.create(name: "button_color")
ExperimentOption.create(experiment: experiment, value: "#FF0000", percentage: 33.3)
ExperimentOption.create(experiment: experiment, value: "#00FF00", percentage: 33.3)
ExperimentOption.create(experiment: experiment, value: "#0000FF", percentage: 33.3)

experiment = Experiment.create(name: "price")
ExperimentOption.create(experiment: experiment, value: "10", percentage: 75)
ExperimentOption.create(experiment: experiment, value: "20", percentage: 10)
ExperimentOption.create(experiment: experiment, value: "50", percentage: 5)
ExperimentOption.create(experiment: experiment, value: "5", percentage: 10)

# it can be done by some sort of bulk insert. but seeds were never a target for perf improvements
1.upto(50_000) do
  client = Client.find_or_create_by(device_token: SecureRandom.uuid)
  ClientSettings::PopulateService.execute(client)
end
