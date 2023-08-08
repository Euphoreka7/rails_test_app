module ClientSettings
  class PopulateService
    def self.execute(client)
      Experiment.select(
          <<~SQL
            experiments.id as experiment_id, experiment_options.id as option_id, experiment_options.percentage,
            (select count(*) from client_settings cs where cs.experiment_option_id = experiment_options.id) as options_count
          SQL
        )
        .joins(:experiment_options)
        .where("experiments.id not in (select experiment_id from client_settings where client_id = ?)", client.id)
        .as_json
        .group_by{|eo| eo['experiment_id']}
        .each do |experiment_id, options|
          option_id = options.map { |o| [o['option_id'], o['options_count'] / o['percentage']] }.sort_by{ |o| o[1] }[0][0]
          client.client_settings.create(experiment_id: experiment_id, experiment_option_id: option_id)
      end
    end
  end
end
