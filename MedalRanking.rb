require_relative 'country.rb'

class MedalRankings
  attr_reader :countries

  def initialize(countries = [])
    @countries = countries
  end

  def load_countries (filename)
    i=0
    begin
      IO.foreach(filename) do |line|
        temp = line.split
        if temp.size == 5
          @countries[i] = Country.new(temp[0].to_s, temp[1].to_i, temp[2].to_i, temp[3].to_i, temp[4].to_i)
          i += 1
        end
      end
    rescue Exception => msg
      'file does not exist'
    end
  end

  def to_s(n)
    #account for negative numbers and amount bigger than available
    if n<1
      raise ArgumentError.new("value #{n} is out of range")
    elsif n > @countries.size
      n = @countries.size
    end
    string = ''
    for i in 0..n-1
      string << @countries[i].to_s
      string << "\n"
    end
    string
  end

  def most_golds
    if @countries.size ==0
      raise ArgumentError.new("The size of the country array is: #{@countries.size}")
    end
    most_gold = -1
    country_gold =0
    @countries.each do |country|
      if country.golds > most_gold
        most_gold = country.golds
        country_gold = country
      end
    end
    country_gold
  end

  def average_pop
    if @countries.size ==0
      raise ArgumentError.new("The size of the country array is: #{@countries.size}")
    end
    population =0
    @countries.each do |country|
      population += country.population
    end
    population.to_f/@countries.size.to_f
  end

  def sort!
    @countries.sort! {|x,y| y.score <=> x.score}
  end

  def each_single_gold_winner
    @countries.each do |country|
      if country.golds == 1 && country.silver ==0 && country.bronze == 0
        yield country
      end
    end

  end

end