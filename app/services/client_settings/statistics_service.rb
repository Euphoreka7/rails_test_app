module ClientSettings
  class StatisticsService
    def self.execute
      ClientSetting.select('experiments.name, experiment_options.value, count(client_settings.id) as clients_count')
                   .joins(:experiment)
                   .joins(:experiment_option)
                   .group('experiments.name, experiment_options.value')
                   .as_json
                   .group_by{|cs| cs['name']}
    end
  end
end
