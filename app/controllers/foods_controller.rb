class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    food = current_user.foods.new(food_params)
    respond_to do |format|
      format.html do
        if food.save
          flash[:notice] = 'Food was saved successfully.'
          redirect_to foods_path
        else
          flash.now[:alert] = 'There was an error Creating the food. Please try again.'
          render :new
        end
      end
    end
  end

  def destroy
    @food = Food.find(params[:id])
    if @food.destroy
      flash[:notice] = 'Food was deleted successfully.'
    else
      flash.now[:alert] = 'There was an error deleting the food.'
    end
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :quantity, :measurement_unit, :price)
  end
end
