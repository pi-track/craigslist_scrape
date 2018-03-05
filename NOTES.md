# Refactoring - Updated from bikes to items

# More Progress 3/2/18
I have a program working that meets the criteria. I need to take a pass and see if there is anywhere I can refactor for simplicity.
Made a first_refactor branch to work on refactoring the CLI.

## CLI
1. make search an instance method in the CLI that 1) makes a new search object, makes bikes from it, and list_bikes them. refactor the main loop and the menu.

# Progress 3/2/18
bin/craigslist_bikes is doing its job and the cli class works through instantiating items(bikes at this point) and displaying a list of them. As I work on it is becoming more and more obvious that I should just make this a generic craigslist scraper, and I can set up a default search that looks for bikes. To do this I'll research a bit to see if other search items have important criteria I'm missing. Another thing I realized is that the right way to solve this problem is really through the RSS reader - this is a good exercise, but not very scalable and a lot more effort than it would be to just eat what the craigslist RSS reader gives me since it is designed exactly for this purpose.. oh well.  

I refactored to get rid of my separate scraper class - it is now a sub-class of the search class. It's working better and is a more logical flow than the way I had it before because the data (url) and the relevant methods (scrape that url) are within the same object.

I'm going to record a screencast (https://youtu.be/srrMLBx5FeI) now of myself working on the code.

Goals:

1. demo where I am
2. scrape more info from the item page itself. (build scrape_item_page method)
2. clean up the display
3. make 'search' for a new search work

#Progress 3/1/18
bin/craigslist-bikes will show you where I'm at again.
I built out a search class that asks a user for input and generates a URL to hit craigslist with. Having a search class makes this trivial to extend beyond bikes. I still like doing bikes.

Work on the scraper tomorrow.

#Progress 2/28/18
run bin/console or bin/craigslist-bikes to see where I'm at.
I'm initializing bikes ok - not sure how i'm going to update them. need to build some methods out for that.
Haven't started on the scraper.  

# craigslist_bikes

Building a CLI to search craigslist philly for bikes and display/sort them. Starting with bikes (because I personally don't search craigslist for anything else) and philly (because I live here) but a goal is to build this so it is open to flexible extension.

## planned functionality

The user experience is something like this.
user types craigslist-bikes
and it asks me a few things specifying my search.
1. What city?
2. What zip code?
3. Within what radius?
4. Posted today?
5. Price Min/Max
6. Any search criteria?

These criteria are all optional and are used to generate the search URL to craigslist. If none are entered it will do some default search logic and display X number of results.  

## Classes

### CommandLineInterface
Handles spinning up the Command Line Interface and flow for user interaction.

### URLGenerator
Gets criteria from the user for the search and turns that into a URL that we can call to get the results we're looking for.

### Scraper
Takes a URL and uses Nokogiri to search for attributes. Puts them in a hash probably.

### Bike
Creates Bike Objects for each search result.

### Display
Not sure if this is a
