require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
  def test_it_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_starts_with_stock_empty
    pantry = Pantry.new

    expected = {}
    actual   = pantry.stock

    assert_equal expected, actual
  end

  def test_can_check_for_items_and_quantities
    pantry = Pantry.new

    expected = 0
    actual   = pantry.stock_check('Cheese')

    assert_equal expected, actual
  end

  def test_can_add_items_to_stock
    pantry = Pantry.new
    pantry.restock('Cheese', 10)

    expected = 10
    actual   = pantry.stock_check('Cheese')

    assert_equal expected, actual
  end

  def test_can_add_more_amount_to_stock
    pantry = Pantry.new
    pantry.restock('Cheese', 10)

    expected = 10
    actual   = pantry.stock_check('Cheese')

    assert_equal expected, actual

    pantry.restock('Cheese', 20)

    expected2 = 30
    actual2   = pantry.stock_check('Cheese')

    assert_equal expected2, actual2
  end

  def test_can_add_to_shopping_list
    pantry = Pantry.new
    recipe = Recipe.new('Cheese Pizza')

    recipe.add_ingredient('Cheese', 20)
    recipe.add_ingredient('Flour',  20)

    pantry.add_to_shopping_list(recipe)

    expected = { 'Cheese' => 20, 'Flour' => 20 }
    actual   = pantry.shopping_list

    assert_equal expected, actual
  end

  def test_can_add_additional_recipes
    pantry = Pantry.new
    recipe = Recipe.new('Cheese Pizza')

    recipe.add_ingredient('Cheese', 20)
    recipe.add_ingredient('Flour',  20)

    pantry.add_to_shopping_list(recipe)

    recipe2 = Recipe.new('Spaghetti')

    recipe2.add_ingredient('Spaghetti Noodles', 10)
    recipe2.add_ingredient('Marinara Sauce',    10)
    recipe2.add_ingredient('Cheese',            5)

    pantry.add_to_shopping_list(recipe2)

    expected = {
      'Cheese'            => 25,
      'Flour'             => 20,
      'Spaghetti Noodles' => 10,
      'Marinara Sauce'    => 10
    }
    actual = pantry.shopping_list

    assert_equal expected, actual
  end

  def test_it_can_print_shopping_list
    pantry = Pantry.new

    recipe = Recipe.new('Cheese Pizza')
    recipe.add_ingredient('Cheese', 20)
    recipe.add_ingredient('Flour',  20)
    pantry.add_to_shopping_list(recipe)

    recipe2 = Recipe.new('Spaghetti')
    recipe2.add_ingredient('Spaghetti Noodles', 10)
    recipe2.add_ingredient('Marinara Sauce',    10)
    recipe2.add_ingredient('Cheese',            5)
    pantry.add_to_shopping_list(recipe2)

    expected =
      "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
    actual   = pantry.print_shopping_list

    assert_equal expected, actual
  end

  def test_it_can_suggest_recipes
    pantry = Pantry.new
    r1 = Recipe.new('Cheese Pizza')
    r1.add_ingredient('Cheese', 20)
    r1.add_ingredient('Flour',  20)

    r2 = Recipe.new('Pickles')
    r2.add_ingredient('Brine',     10)
    r2.add_ingredient('Cucumbers', 30)

    r3 = Recipe.new('Peanuts')
    r3.add_ingredient('Raw nuts', 10)
    r3.add_ingredient('Salt',     10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)
  end
end
