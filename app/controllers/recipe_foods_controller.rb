class RecipeFoodsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    unless @recipe.user == current_user
      flash[:alert] = 'You can only add foods to your own recipes.'
      redirect_to recipe_path(@recipe)
    end
    @recipe_food = RecipeFood.new
    @foods = current_user.foods
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe = @recipe
    if @recipe_food.save
      flash[:notice] = 'Food added to recipe.'
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = 'Food not added to recipe.'
      render :new
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe
    if @recipe_food.destroy
      flash[:notice] = 'Food removed from recipe.'
    else
      flash[:alert] = 'Food not removed from recipe.'
    end
    redirect_to recipe_path(@recipe)
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
