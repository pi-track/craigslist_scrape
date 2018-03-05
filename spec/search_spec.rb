require_relative './spec_helper'

RSpec.describe CraigslistScrape::Search do
  describe "returns good urls" do
    it "for a basic search" do
      search_criteria = {:city=>"philadelphia"}
      search = CraigslistScrape::Search.new(search_criteria)

      expect(search.search_URL).to eq("https://philadelphia.craigslist.org/search/bik?query=&search_distance=&postal=&min_price=&max_price=&postedToday=")
    end

    it 'for a complex search' do
      search_criteria = {:city=>"philadelphia", :zip_code=>"19147", :search_radius=>"3", :posted_today=>"1", :price_max=>"1000", :price_min=>"10", :query=>"bike"}
      search = CraigslistScrape::Search.new(search_criteria)
      expect(search.search_URL.split("").sort).to eq("https://philadelphia.craigslist.org/search/bik?query=bike&postedToday=1&search_distance=3&postal=19147&min_price=10&max_price=1000".split("").sort)
    end
  end
end
