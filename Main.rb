require_relative 'MedalRanking.rb'

Medalranks = MedalRankings.new
Medalranks.load_countries('medals.txt')

puts "County with the most gold: #{Medalranks.most_golds.to_s}"

puts "\nAverage Population: #{Medalranks.average_pop}"

Medalranks.sort!
puts "\nTop 10 countries sorted by score"
puts Medalranks.to_s(10)

puts "\nCountries with only 1 gold"
Medalranks.each_single_gold_winner {|z| puts z.to_s}