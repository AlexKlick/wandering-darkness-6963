class Garden < ApplicationRecord
  has_many :plots

  def plants_less_100_days
    plots
    .select('plants.*, COUNT(plants.name) as plant_count')
    .joins(:plants)
    .where('plants.days_til_harvest < 100')
    .group('plants.id')
    .order('plant_count desc')
    .uniq
  end
end
