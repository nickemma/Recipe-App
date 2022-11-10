class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  

  def new
    @recipe = Recipe.new
  end

  def public
    @totals = {}
    @public_recipes = Recipe.where(public: true).order('created_at DESC')
    @public_recipes.each do |pub|
      total = 0
      RecipeFood.where(recipe_id: pub.id).each do |rec_food|
        total += rec_food.quantity * rec_food.food.price
      end
      @totals[pub.name] = total
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      flash[:notice] = 'Recipe was saved successfully.'
      redirect_to recipes_path
    else
      flash.now[:alert] = 'There was an error creating the recipe. Please try again.'
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:notice] = 'Recipe was deleted successfully.'
    else
      flash.now[:alert] = 'There was an error deleting the recipe.'
    end
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :cooking_time, :preparation_time, :description, :public)
  end
end
