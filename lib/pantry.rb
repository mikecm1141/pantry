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
end
