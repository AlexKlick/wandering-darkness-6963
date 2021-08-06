require 'rails_helper'

RSpec.describe 'Plot Index' do
  before(:each) do
    @garden = Garden.create(name:'Golden Blossom', organic: true)
    @plot1 = Plot.create(number: 25, size:"medium", direction:"west", garden_id:@garden.id)
    @plot2 = Plot.create(number: 10, size:"large", direction:"south", garden_id:@garden.id)
    @plant1 = Plant.create(name:'lilly', description:'water lilly', days_til_harvest: 100)
    @plant2 = Plant.create(name:'bonsai', description:'zen garden nececity, I cant spell', days_til_harvest: 100)
    @plant3 = Plant.create(name:'apple', description:'juicy and full of vitamin c', days_til_harvest: 100)
    @plant4 = Plant.create(name:'cherry blossom', description:'prettiest flower', days_til_harvest: 100)
    @plant_plots1 = @plot1.plot_plants.create(plant_id:@plant1.id)
    @plant_plots2 = @plot1.plot_plants.create(plant_id:@plant2.id)
    @plant_plots3 = @plot1.plot_plants.create(plant_id:@plant3.id)
    @plant_plots4 = @plot1.plot_plants.create(plant_id:@plant4.id)
    @plant_plots5 = @plot2.plot_plants.create(plant_id:@plant1.id)
    @plant_plots6 = @plot2.plot_plants.create(plant_id:@plant2.id)
    visit "/plots"
  end
  # As a visitor
  # When I visit the plots index page ('/plots')
  # I see a list of all plot numbers
  # And under each plot number I see names of all that plot's plants
  it 'has all of the plot numbers and under this, all of the plots plant names' do

    expect(page).to have_content(@plot1.number)
    expect(page).to have_content(@plot2.number)

    within("#plot#{@plot1.id}") do
      expect(page).to have_content(@plant1.name)
      expect(page).to have_content(@plant2.name)
      expect(page).to have_content(@plant3.name)
      expect(page).to have_content(@plant4.name)
    end

    within("#plot#{@plot2.id}") do
      expect(page).to have_content(@plant1.name)
      expect(page).to have_content(@plant2.name)
    end
  end

  #   When I visit a plot's index page
  # Next to each plant's name
  # I see a link to remove that plant from that plot
  # When I click on that link
  # I'm returned to the plots index page
  # And I no longer see that plant listed under that plot
  # (Note: you should not destroy the plant record entirely)
  it 'has a delete link next to each plant' do

    within("#plot#{@plot1.id}") do
      expect(page).to have_link("delete #{@plant1.name}")
      expect(page).to have_link("delete #{@plant2.name}")
      expect(page).to have_link("delete #{@plant3.name}")
      expect(page).to have_link("delete #{@plant4.name}")
    end

    within("#plot#{@plot2.id}") do
      expect(page).to have_link("delete #{@plant1.name}")
      expect(page).to have_link("delete #{@plant2.name}")
    end
  end
  describe 'when I click the delete button next to a plant' do
    it 'returns to /plots and that plant is no longer listed under plot' do

      within("#plot#{@plot2.id}") do
        click_on("delete #{@plant2.name}")
      end

      expect(current_path).to eq("/plots")

      within("#plot#{@plot2.id}") do
        expect(page).to_not have_link(@plant2.name)
      end
    end
  end
end