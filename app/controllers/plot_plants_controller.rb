class PlotPlantsController < ApplicationController
  
  def destroy
    plot_plant = PlotPlant.find(plot_plant_params[:id])
    plot_plant.destroy
    redirect_to '/plots'
  end

  private

  def plot_plant_params
    params.permit(:id)
  end
end