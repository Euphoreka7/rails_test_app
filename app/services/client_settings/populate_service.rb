module ClientSettings
  class PopulateService
    def self.execute(client)
      Experiment.select("experiments.id as experiment_id, experiment_options.id as option_id, experiment_options.percentage")
                .joins(:experiment_options)
                .where("experiments.id not in (select experiment_id from client_settings where client_id = ?)", client.id)
                .as_json
                .group_by{|eo| eo['experiment_id']}
                .each do |experiment_id, options|
        max_percentage = options.map { |o| o['percentage'] }.sum
        r_val = rand(0..max_percentage)
        current_percentage = 0.0
        options.each do |option|
          current_percentage += option['percentage']
          if r_val <= current_percentage
            client.client_settings.create(experiment_id: experiment_id, experiment_option_id: option['option_id'])
            break
          end
        end
      end
    end
  end
end
