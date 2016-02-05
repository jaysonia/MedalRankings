
module GDP

  @@country_gdp = Hash.new

  def read_file
    if File.exist?('gdp.txt')
      IO.foreach('gdp.txt') do |line|
        temp = line.split
        if temp.size == 2
          @@country_gdp.store(temp[0], temp[1])
        end
      end
    end
  end



end