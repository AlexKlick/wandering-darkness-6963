require 'rails_helper'

RSpec.describe 'Plot Index' do
  before(:each) do
    @garden = Garden.create(name:'Golden Blossom', organic: true)
    @plot1 = Plot.create(number: 25, size:"medium", direction:"west", garden_id:@garden.id)
    @plot2 = Plot.create(number: 10, size:"large", direction:"south", garden_id:@garden.id)
    @plant1 = Plant.create(name:'lilly', description:'water lilly')
    @plant2 = Plant.create(name:'bonsai', description:'zen garden nececity, I cant spell')
    @plant3 = Plant.create(name:'apple', description:'juicy and full of vitamin c')
    @plant4 = Plant.create(name:'cherry blossom', description:'prettiest flower')
    @plant_plots1 = @plot1.plot_plants.create(plant_id:@plant1.id)
    @plant_plots2 = @plot1.plot_plants.create(plant_id:@plant2.id)
    @plant_plots3 = @plot1.plot_plants.create(plant_id:@plant3.id)
    @plant_plots4 = @plot1.plot_plants.create(plant_id:@plant4.id)
    @plant_plots5 = @plot2.plot_plants.create(plant_id:@plant1.id)
    @plant_plots6 = @plot2.plot_plants.create(plant_id:@plant2.id)
  end
  # As a visitor
  # When I visit the plots index page ('/plots')
  # I see a list of all plot numbers
  # And under each plot number I see names of all that plot's plants
  it 'has all of the plot numbers and under this, all of the plots plant names' do
    visit "/plots"

    expect(page).to have_content(@plot1.number)
    expect(page).to have_content(@plot2.number)

    within("#plot#{@plot1.id}") do
      expect(page).to have_content(@plant_plots1.name)
      expect(page).to have_content(@plant_plots2.name)
      expect(page).to have_content(@plant_plots3.name)
      expect(page).to have_content(@plant_plots4.name)
    end

    within("#plot#{@plot2.id}") do
      expect(page).to have_content(@plant_plots5.name)
      expect(page).to have_content(@plant_plots6.name)
    end
  end
end