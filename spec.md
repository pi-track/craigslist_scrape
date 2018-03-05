# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
   Run bin/craigslist-scrape launches a CLI which allows user to interact with the code by defining a search or using a default search.
- [x] Pull data from an external source
   After defining a search a URL is generated and then the craigslist results page is scraped using open-uri and nokogiri.
- [x] Implement both list and detail views
   A list view is returned after the search is complete. By selecting an item from the list the user can see more detail on the item.
