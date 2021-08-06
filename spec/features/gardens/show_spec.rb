require 'rails_helper'

RSpec.describe 'Plot Index' do
  before(:each) do
    @garden = Garden.create(name:'Golden Blossom', organic: true)
    @plot1 = Plot.create(number: 25, size:"medium", direction:"west", garden_id:@garden.id)
    @plot2 = Plot.create(number: 10, size:"large", direction:"south", garden_id:@garden.id)
    @plant1 = Plant.create(name:'lilly', description:'water lilly', days_til_harvest: 99)
    @plant2 = Plant.create(name:'bonsai', description:'zen garden nececity, I cant spell', days_til_harvest: 20)
    @plant3 = Plant.create(name:'apple', description:'juicy and full of vitamin c', days_til_harvest: 100)
    @plant4 = Plant.create(name:'cherry blossom', description:'prettiest flower', days_til_harvest: 101)
    @plant_plots1 = @plot1.plot_plants.create(plant_id:@plant1.id)
    @plant_plots2 = @plot1.plot_plants.create(plant_id:@plant2.id)
    @plant_plots3 = @plot1.plot_plants.create(plant_id:@plant3.id)
    @plant_plots4 = @plot1.plot_plants.create(plant_id:@plant4.id)
    @plant_plots5 = @plot2.plot_plants.create(plant_id:@plant1.id)
    @plant_plots6 = @plot2.plot_plants.create(plant_id:@plant2.id)
    visit "/gardens/#{@garden.id}"
  end
  # As a visitor
  # When I visit an garden's show page
  # Then I see a list of plants that are included in that garden's plots
  # And I see that this list is unique (no duplicate plants)
  # And I see that this list only includes plants that take less than 100 days to harvest
  it 'has a uniq list of plants in the garden, all of which take less than 100 days to harvest' do
    
    expect(page).to have_content(@plant1.name, count: 1)
    expect(page).to have_content(@plant2.name, count: 1)

  end
end