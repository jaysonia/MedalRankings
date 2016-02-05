require_relative 'GDP.rb'

class Country
  include GDP
  attr_reader :country, :golds, :silver, :bronze, :population

  def initialize(country,gold,silver,bronze,pop)
    @country = country
    @golds = gold
    @silver = silver
    @bronze = bronze
    @population = pop
    #only call the readfile from the module if it hasn't already
    if @@country_gdp.size == 0
      self.read_file
    end
  end

  def score
    ((@golds*3)+(@silver*2)+@bronze ).to_f/@@country_gdp[@country].to_f
  end

  def to_s
    "#{@country}, #{@golds}, #{@silver}, #{@bronze}, #{@population}"
  end
end