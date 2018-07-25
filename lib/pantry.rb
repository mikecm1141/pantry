require './lib/recipe'

class Pantry
  attr_reader :stock,
              :shopping_list

  def initialize
    @stock         = Hash.new(0)
    @shopping_list = Hash.new(0)
    @cookbook      = []
  end

  def stock_check(item)
    @stock[item]
  end

  def restock(item, amount)
    @stock[item] += amount
  end

  def add_to_shopping_list(recipe)
    ingredients = recipe.ingredients
    ingredients.each do |item, amount|
      @shopping_list[item] += amount
    end
  end

  def print_shopping_list
    @shopping_list.inject('') do |list, (item, amount)|
      list + "* #{item}: #{amount}\n"
    end.chomp
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    able_to_make = []
    @cookbook.each do |recipe|
      valid_recipe = recipe.ingredient_types.all? do |ingredient|
        recipe.amount_required(ingredient) <= @stock[ingredient]
      end
      able_to_make << recipe.name if valid_recipe
    end
    able_to_make
  end

  def how_many_can_i_make
    recipe_names     = what_can_i_make
    recipe_objects   = find_recipes_by_name(recipe_names)
    amount_available = Hash.new(0)

    recipe_objects.each do |recipe|
      amount = recipe.ingredient_types.map do |ingredient|
        @stock[ingredient] / recipe.amount_required(ingredient)
      end
      amount_available[recipe.name] = amount.min
    end
    amount_available
  end

  private
  
  def find_recipes_by_name(recipes)
    @cookbook.find_all do |recipe|
      recipes.member?(recipe.name)
    end
  end
end
