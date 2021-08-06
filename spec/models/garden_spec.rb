require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end
  describe 'class methods' do

  end
  describe 'instance methods' do
    before(:each) do
      @garden = Garden.create(name:'Golden Blossom', organic: true)
      @plot1 = Plot.create(number: 25, size:"medium", direction:"west", garden_id:@garden.id)
      @plot2 = Plot.create(number: 10, size:"large", direction:"south", garden_id:@garden.id)
      @plant1 = Plant.create(name:'lilly', description:'water lilly', days_til_harvest: 99)
      @plant2 = Plant.create(name:'bonsai', description:'zen garden nececity, I cant spell', days_til_harvest: 20)
      @plant3 = Plant.create(name:'apple', description:'juicy and full of vitamin c', days_til_harvest: 100)
      @plant4 = Plant.create(name:'cherry blossom', description:'prettiest flower', days_til_harvest: 75)
      @plant_plots1 = @plot1.plot_plants.create(plant_id:@plant1.id)
      @plant_plots2 = @plot1.plot_plants.create(plant_id:@plant2.id)
      @plant_plots3 = @plot1.plot_plants.create(plant_id:@plant3.id)
      @plant_plots4 = @plot1.plot_plants.create(plant_id:@plant4.id)
      @plant_plots5 = @plot2.plot_plants.create(plant_id:@plant1.id)
      @plant_plots6 = @plot2.plot_plants.create(plant_id:@plant2.id)
      @plant_plots7 = @plot1.plot_plants.create(plant_id:@plant2.id)
      #plant2 shows up 3 times, plant1 shows up twice, all others show up once
    end
    describe 'plants_less_100_days' do
      it 'returns the unique plants from a garden that require less than 100 days to harvest' do
        expect(@garden.plants_less_100_days[0].name).to eq(@plant1.name)
        expect(@garden.plants_less_100_days[1].name).to eq(@plant2.name)
        expect(@garden.plants_less_100_days[2].name).to eq(@plant4.name)
      end
    end
  end
end

