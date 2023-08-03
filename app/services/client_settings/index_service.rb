module ClientSettings
  class IndexService
    def self.execute(client)
      client.client_settings
            .joins(:experiment)
            .joins(:experiment_option)
            .select('experiments.name, experiment_options.value')
            .as_json
            .map { |e| { e['name'] => e['value'] } }
            .reduce({}, :merge)
    end
  end
end
