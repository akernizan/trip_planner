require 'httparty'
require 'cgi'

class TripPlanner
  attr_reader :user, :forecast, :recommendation
  
  def initialize
    # Should be empty, you'll create and store @user, @forecast and @recommendation elsewhere
  end
  
  def plan
    # Plan should call create_user, retrieve_forecast and create_recommendation 
    # After, you should display the recommendation, and provide an option to 
    # save it to disk.  There are two optional methods below that will keep this
    # method cleaner.
        


  end
  
  # def display_recommendation

  # end
  #
  # def save_recommendation
  # end
  
  def create_user(name,destination,duration)
    # provide the interface asking for name, destination and duration
    # then, create and store the User object
    puts "Name: "
    puts = gets.chomp

    puts "Destination: "
    puts = gets.chomp

    puts "Duration: "
    puts = gets.chomp


    @User = User.new(name, destination, duration)
  end
  
  def retrieve_forecast
    # use HTTParty.get to get the forecast, and then turn it into an array of
    # Weather objects... you  might want to institute the two methods below
    # so this doesn't get out of hand...
   
    @retrieve_forecast = call_api.parse_result

  end
  
  def call_api
    response = HTTParty.get("http://api.openweathermap.org/data/2.5/forecast/#{options}")
  end
  
  def parse_result
    result = JSON.parse(response.body)
  end
  
  def create_recommendation
    # once you have the forecast, ask each Weather object for the appropriate
    # clothing and accessories, store the result in @recommendation.  You might
    # want to implement the two methods below to help you kee this method
    # smaller...
    @recommendation = collect_clothes.collect_accessories
  end
  
  # def collect_clothes
  # end
  #
  # def collect_accessories
  # end
end

class Weather
  attr_reader :min_temp, :max_temp, :condition
  
  # given any temp, we want to search CLOTHES for the hash
  # where min_temp <= temp and temp <= max_temp... then get
  # the recommendation for that temp.
  CLOTHES = [
    {
      min_temp: -50, max_temp: 0,
      recommendation: [
        "insulated parka", "long underwear", "fleece-lined jeans",
        "mittens", "knit hat", "chunky scarf"
      ]
    }
  ]

  ACCESSORIES = [
    {
      condition: "Rainy",
      recommendation: [
        "galoshes", "umbrella"
      ]
    }
  ]
  
  def initialize(min_temp, max_temp, condition)
    @min_temp = min_temp
    @max_temp = max_temp
    @condition = condition
  end
  
  def self.clothing_for(temp)
    # This is a class method, have it find the hash in CLOTHES so that the 
    # input temp is between min_temp and max_temp, and then return the 
    # recommendation.

      CLOTHES.select do |temp|
        if (CLOTHES[:min_temp] == -50) 
          puts "You should wear a #{@min_temp}"
        else (CLOTHES[:max_temp] <= 0)
          puts "You should wear #{@max_temp}"
      end
  end
  
  def self.accessories_for(condition)
    # This is a class method, have it find the hash in ACCESSORIES so that
    # the condition matches the input condition, and then return the
    # recommendation.

        ACCESSORIES.select do |condition|
         if ACCESSORIES[:condition] == @condition
              puts "You should wear #{ACCESSORIES[:recommendation]}"
            
          end 
  end
  
  def appropriate_clothing
    # Use the results of Weather.clothing_for(@min_temp) and 
    # Weather.clothing_for(@max_temp) to make an array of appropriate
    # clothing for the weather object.
    # You should avoid making the same suggestion twice... think
    # about using .uniq here
      appropriate_clothing = CLOTHES[:recommendation].uniq {|c| c.sample}



  end
  
  def appropriate_accessories
    # Use the results of Weather.accessories_for(@condition) to make
    # an array of appropriate accessories for the weather object.
    # You should avoid making the same suggestion twice... think
    # about using .uniq here

    appropriate_clothing = CLOTHES[:recommendation].uniq {|r| r.sample}
  end
end

class User
  attr_reader :name, :destination, :duration
  
  def initialize(name, destination, duration)
    @name = name
    @destination = destination
    @duration = duration
  end
end

trip_planner = TripPlanner.new
trip_planner.start
