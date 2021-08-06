class Garden < ApplicationRecord
  has_many :plots

  def plants_less_100_days
    plots
    .select('plants.*')
    .joins(:plants)
    .where('plants.days_til_harvest < 100')
    .uniq
  end
end
