require 'test/unit'
require_relative 'MedalRanking.rb'

TEST_COUNTRY1 = [
    Country.new('IRL', 1, 1, 1, 10000),
    Country.new('USA', 34, 16, 66, 30600500),
    Country.new('FRA', 1, 1, 1, 10000),
    Country.new('POR', 1, 1, 1, 10000)
]

TEST_COUNTRY_HIGHEST_GOLD = [
    Country.new('IRL', 5, 2, 1, 3000000),
    Country.new('USA', 34, 16, 66, 30600500),
    Country.new('FRA', 16, 34, 12, 50467520),
    Country.new('POR', 14, 6, 4, 4631024)
]

TEST_COUNTRY_AVERAGE = [
    Country.new('IRL', 1, 1, 1, 10000),
    Country.new('USA', 1, 1, 1, 10000),
    Country.new('FRA', 1, 1, 1, 10000),
    Country.new('POR', 1, 1, 1, 10000)
]

TEST_ONE_GOLD = [
    Country.new('IRL', 1, 1, 1, 10000),
    Country.new('USA', 1, 1, 1, 10000),
    Country.new('FRA', 1, 0, 0, 10000),
    Country.new('POR', 1, 1, 1, 10000)
]

class MedalRankingTest < Test::Unit::TestCase

  def setup
    @rankings = MedalRankings.new(TEST_COUNTRY1)
  end

  def test_countries
    assert_equal('IRL', @rankings.countries[0].country, 'First position not equal to IRE')
    assert_equal('POR', @rankings.countries[3].country, 'final position not equal to POR')
    assert_equal(1, @rankings.countries[0].golds, 'Golds for ireland is not correct')
    assert_equal(34, @rankings.countries[1].golds, 'Golds for USA is not correct.')
    assert_equal(4, @rankings.countries.size, 'Size of countries is not what is expected')
  end

  def test_to_s
    assert_equal("IRL, 1, 1, 1, 10000\nUSA, 34, 16, 66, 30600500\n", @rankings.to_s(2), 'Returned string is incorrect')
    assert_equal("IRL, 1, 1, 1, 10000\nUSA, 34, 16, 66, 30600500\nFRA, 1, 1, 1, 10000\n", @rankings.to_s(3), 'Returned string is incorrect')
    #test beyond range
    assert_equal("IRL, 1, 1, 1, 10000\nUSA, 34, 16, 66, 30600500\nFRA, 1, 1, 1, 10000\nPOR, 1, 1, 1, 10000\n",@rankings.to_s(6),'out of range no handled')
    #test argument is throw if it is out of range
    assert_raise ArgumentError do
      @rankings.to_s(0)
      puts 'valid'
    end
  end

  def test_average
    @rankings = MedalRankings.new(TEST_COUNTRY_AVERAGE)
    assert_in_delta(10000, @rankings.average_pop, 'incorrect average calculated')
  end

  def test_highest_gold
    @rankings = MedalRankings.new(TEST_COUNTRY_HIGHEST_GOLD)
    assert_equal(@rankings.countries[1], @rankings.most_golds, 'Highest golds calculated incorrectly')
  end

  def test_sort
    @rankings = MedalRankings.new(TEST_COUNTRY_HIGHEST_GOLD)
    assert_equal("IRL, 5, 2, 1, 3000000\n", @rankings.to_s(1), 'Incorrect first item before sort.')
    @rankings.sort!
    assert_equal("POR, 14, 6, 4, 4631024\n", @rankings.to_s(1),'Incorrect item in the first spot after sort')

  end

  def test_read_file
    @rankings = MedalRankings.new
    #test for invalid files
    assert_equal("file does not exist", @rankings.load_countries(''), 'incorrect file name')
    @rankings.load_countries('medals.txt')
    assert_equal("AFG, 0, 0, 1, 34385000\n", @rankings.to_s(1), 'after file read first country is incorrect')
  end

  def test_each_gold
    @rankings = MedalRankings.new(TEST_ONE_GOLD)
    @rankings.each_single_gold_winner {|z| assert_equal("FRA, 1, 0, 0, 10000",z.to_s,'')}
  end

end