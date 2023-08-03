class StatisticsController < ApplicationController
  def show
    @statistics = ClientSettings::StatisticsService.execute
  end
end
