require 'rails_helper'

RSpec.describe PlotPlant do
  describe 'relationships' do
    it { should belong_to(:plot) }
    it { should belong_to(:plant) }
  end

  describe 'class methods' do

  end
  describe 'instance methods' do

  end
end