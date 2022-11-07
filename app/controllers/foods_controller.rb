class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = Food.all
    # @foods = @user.foods.order(:created_at :desc)
  end

  def new
    @food = Food.new
  end

  def create 
    food = Food.new(food_params)
    food.user = current_user
    if @food.save
      flash[:notice] = "Food was saved successfully."
     else
      flash.now[:alert] = "Error creating food. Please try again."
     end
     redirect_to foods_path
  end

  def destroy 
    @food = Food.find(params[:id])
    if @food.destroy
      flash[:notice] = "Food was deleted successfully."
     else
      flash.now[:alert] = "There was an error deleting the food."
     end
     redirect_to foods_path
  end

  private 

  def food_params
    params.require(:foods).permit(:name, :measurement_unit, :price)
  end
end