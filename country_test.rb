require 'test/unit'
require_relative 'country.rb'

class CountryTest < Test::Unit::TestCase

  def setup
    @country = Country.new('IRL', 1, 1, 3, 4475000)
  end

  def test_initialize
    assert_equal(@country.country, 'IRL', 'Country name not equal IRL')
    assert_equal(@country.golds, 1, 'Value for golds is incomplete')
    assert_equal(@country.silver, 1, 'Value for silver is incorrect')
    assert_equal(@country.bronze, 3, 'Value for bronze is incorrect')
    assert_equal(@country.population, 4475000, 'Value for population is incorrect')
  end

  def test_to_s
    assert_equal('IRL, 1, 1, 3, 4475000',@country.to_s, 'Returned string value for country is incorrect')
  end

  def test_score
    assert_equal((3.0+2.0+3.0)/217275000000.0 ,@country.score, 'Score is incorrect')
  end

end