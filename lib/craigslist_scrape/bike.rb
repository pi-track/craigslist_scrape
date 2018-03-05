class CraigslistScrape::Bike
  attr_accessor :name, :price, :url, :neighborhood, :date, :condition, :make, :model, :size, :mapaddress, :maplink, :description, :available

  #collect all instances of Scrape
  @@all = []

  def self.all
    #expose all instances of bikes
    @@all
  end

  def self.bikes
    self.all
  end

  def initialize(attributes)
    attributes.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.new_from_index_page(b)
    attributes = {}
    attributes[:name] = b.css("p > a").text.strip
    attributes[:price] = b.css("p > span.result-meta > span.result-price").text.gsub("$","").strip
    attributes[:url] = b.css("p > a").attribute("href").value.strip
    attributes[:neighborhood] = b.css("p > span.result-meta > span.result-hood").text.strip
    attributes[:date] = b.css("p > time").attribute("datetime").value.strip
    self.new(attributes)
  end

  def scrape_item_page
    #TODO - Raise errors if certain attributes don't exist?
    doc = Nokogiri::HTML(open(url))

    #adds attributes - condition make model size
    doc.css("body > section > section > section > div.mapAndAttrs > p > span").each do |a|
      self.send("#{a.text.split(":").first.split.first}=","#{a.text.split(":").last}")
    end

    #adds additional attributes
    @description = doc.css("#postingbody").text.gsub("QR Code Link to This Post","").strip
    @mapaddress = doc.css("body > section > section > section > div.mapAndAttrs > div > div.mapaddress").text.strip
    @maplink = doc.css("body > section > section > section > div.mapAndAttrs > div > p > small > a").attribute("href").value.strip unless doc.css("body > section > section > section > div.mapAndAttrs > div > p > small > a").empty?
  end

  def display
    required_attrs = [:name, :price, :url, :date]
    optional_attrs = [:neighborhood, :condition, :make, :model, :size, :mapaddress, :maplink]
    puts ""
    puts "----------------------------------------"
    puts ""
    required_attrs.each do |a|
      title = a.to_s
      title[0] = title[0].capitalize
      print "#{title}:"
      (15-title.size).times {print " "}
      puts "#{send(a.to_s)}"
    end
    optional_attrs.each do |a|
      if send(a.to_s)
        title = a.to_s
        title[0] = title[0].capitalize
        print "#{title}:"
        (15-title.size).times {print " "}
        puts "#{send(a.to_s)}"
      end
    end
    puts ""
    puts "---------------Description--------------"
    puts ""
    puts "#{description}"
    puts ""
  end
end
