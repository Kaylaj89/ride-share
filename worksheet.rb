########################################################
# Step 1: Establish the layers

# In this section of the file, as a series of comments,
# create a list of the layers you identify.
# Which layers are nested in each other?
# Which layers of data "have" within it a different layer?
# Which layers are "next" to each other?

#~~~~NOUNS/OBJECTS~~~~~
# Driver,
# Date,
# Cost,
# Rider,
# Rating,
# Ride
# Rides
#~~~RELATIONSHIPS TO EACH OTHER~~~~~~
# A ride has a driver and a rider and a cost and a date
# A driver has an id and a rating
# A rider has an id

########################################################
# Step 2: Assign a data structure to each layer

# Copy your list from above, and in this section
# determine what data structure each layer should have

# Driver - Sits within a single ride hash. Nested within: Hash with Driver Id & Rating
# Date - Sits within a single ride hash
# Cost - Sits within a single ride hash
# Rider - Sits within a single ride hash. Nested within: Hash with Rider Id (for scalability)
# Rating - Nested in Driver hash
# Rides = Outermost Layer - An array that holds several 'ride' hashes

#Looks like
# Rides [
# 	ride
# 		{
# 			Date
# 			Driver {
# 				id
# 				rating
# 				}
# 			Rider{
# 				id
# 				}
# 			Cost {
# 				}
# 		}
# ]

########################################################
# Step 3: Make the data structure!

# Setup the entire data structure:
# based off of the notes you have above, create the
# and manually write in data presented in rides.csv
# You should be copying and pasting the literal data
# into this data structure, such as "DR0004"
# and "3rd Feb 2016" and "RD0022"

rides = [
    {
        date: "3rd Feb 2016",
        driver:
            {
                id:"DR0001",
                rating: 3
            },
        rider:
            {
                id:"RD0003"
            },
        cost: 10
    },
    {
        date: "3rd Feb 2016",
        driver:
            {
                id: "DR0001",
                rating: 4
            },
        rider:
            {
                id:"RD0015"
            },
        cost: 30
    },
    {
        date: "5th Feb 2016",
        driver:
            {
                id: "DR0001",
                rating: 2
            },
        rider:
            {
                id:"RD0003"
            },
        cost: 45
    },
    {
        date: "3rd Feb 2016",
        driver:
            {
                id: "DR0002",
                rating: 5
            },
        rider:
            {
                id:"RD0073"
            },
        cost: 25
    },
    {
        date: "4th Feb 2016",
        driver:
            {
                id: "DR0002",
                rating: 1
            },
        rider:
            {
                id:"RD0013"
            },
        cost: 15
    },
    {
        date: "5th Feb 2016",
        driver:
            {
                id: "DR0002",
                rating: 3
            },
        rider:
            {
                id:"RD0066"
            },
        cost: 35
    },
    {
        date: "4th Feb 2016",
        driver:
            {
                id: "DR0003",
                rating: 5
            },
        rider:
            {
                id:"RD0066"
            },
        cost: 5
    },
    {
        date: "5th Feb 2016",
        driver:
            {
                id: "DR0003",
                rating: 2
            },
        rider:
            {
                id:"RD0003"
            },
        cost: 50
    },
    {
        date: "3rd Feb 2016",
        driver:
            {
                id: "DR0004",
                rating: 5
            },
        rider:
            {
                id:"RD0022"
            },
        cost: 5
    },
    {
        date: "4th Feb 2016",
        driver:
            {
                id: "DR0004",
                rating: 4
            },
        rider:
            {
                id:"RD0022"
            },
        cost: 10
    },
    {
        date: "5th Feb 2016",
        driver:
            {
                id: "DR0004",
                rating: 5
            },
        rider:
            {
                id:"RD0073"
            },
        cost: 20
    }
]

########################################################
# Step 4: Total Driver's Earnings and Number of Rides

# Use an iteration blocks to print the following answers:
# - the number of rides each driver has given
# - the total amount of money each driver has made
# - the average rating for each driver
# - Which driver made the most money?
# - Which driver has the highest average rating?

#this method returns a total number of rides by a given driver from a data set 'rides'
def get_ride_count_by_driver(driver_id, rides)
  count = 0
  rides.each do |ride|
    if ride[:driver][:id] == driver_id
      count += 1
    end
  end
  return count
end

#this method returns the total money made by a given driver from the data set 'rides'
def get_total_money_made_by_driver (driver_id, rides)
  total_money = 0
  rides.each do |ride|
    if ride[:driver][:id] == driver_id
      total_money += ride[:cost]
    end
  end
  return total_money
end

#this method returns the average rating made by a given driver from the data set 'rides'
def get_average_rating_by_driver (driver_id, rides)
  rating_sum = 0.0
  rides.each do |ride|
    if ride[:driver][:id] == driver_id
      rating_sum += ride[:driver][:rating]
    end
  end
  return rating_sum / get_ride_count_by_driver(driver_id, rides)
end

#this method returns the array of the highest_paid driver_ids from the data set 'rides'
def get_drivers_with_most_money (driver_ids, rides)
  highest_paid = {
      drivers: [],
      amount: 0.00
  }

  driver_ids.each do |driver_id|

    current_driver_money = get_total_money_made_by_driver(driver_id, rides)

    if current_driver_money > highest_paid[:amount]
      highest_paid[:drivers].clear #empties amount from highest paid hash if new high high value found
      highest_paid[:amount] = current_driver_money
      highest_paid[:drivers] << driver_id
    elsif current_driver_money == highest_paid[:amount]
      highest_paid[:drivers] << driver_id
    end
  end
  return highest_paid
end

#This method returns the array of the highest_rated driver_ids from the data set 'rides'
def get_drivers_with_highest_average_rating (driver_ids, rides)
  highest_rated = {
      drivers: [],
      rating: 0.0
  }
  driver_ids.each do |driver_id|

    current_driver_average_rating = get_average_rating_by_driver(driver_id, rides)

    if current_driver_average_rating > highest_rated[:rating]
      highest_rated[:drivers].clear #empties rating from highest paid hash if new high high rating found
      highest_rated[:rating] = current_driver_average_rating
      highest_rated[:drivers] << driver_id
    elsif current_driver_average_rating == highest_rated[:rating]
      highest_rated[:drivers] << driver_id
    end
  end
  return highest_rated
end

#PROGRAM STARTS
#Local variable array to collect unique driver_ids
driver_ids = rides.map {|ride| ride[:driver][:id]}.uniq

#Output Message
puts "*" * 65
puts "\n\tRide Share Tally\n\n".upcase

#Beginning of Loop 1
driver_ids.each do |driver_id|

  #The number of rides each driver has given
  puts "\tDriver #{driver_id}:"
  puts "\t\t* gave #{get_ride_count_by_driver(driver_id, rides)} rides"

  #The total amount of money each driver has made
  puts "\t\t* earned $#{get_total_money_made_by_driver(driver_id, rides)} dollars"

  #The average rating for each driver
  puts "\t\t* has an average rating of #{get_average_rating_by_driver(driver_id,rides).round(1)} stars\n\n"

end

#Loops 2 and 3 to find highest paid and highest rated (methods account for collisions)
highest_paid = get_drivers_with_most_money(driver_ids, rides)

puts "\tThe highest paid driver(s):".upcase
highest_paid[:drivers].each do |driver|
  puts "\t\t* #{driver} with $#{highest_paid[:amount]} dollars.\n\n"

end

highest_rated = get_drivers_with_highest_average_rating(driver_ids, rides)
puts "\tdriver(s) with a highest average rating:".upcase

highest_rated[:drivers].each do |driver|
  puts "\t\t* #{driver} -  #{highest_rated[:rating].round(1)} stars!\n\n"
end
puts "*" * 65
exit

