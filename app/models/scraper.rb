class Scraper

  def get_kegs
    url1 = "http://www.hazelsboulder.com/main.asp?request=search&type=B&sel_category=20977&user1=15.5+GALLON&pageNo=1"
    url2 = "http://www.hazelsboulder.com/main.asp?request=search&type=B&sel_category=20977&user1=15.5+GALLON&pageNo=2"
    page1 = Nokogiri::HTML(open(url1))
    page2 = Nokogiri::HTML(open(url2))

    pages = [page1, page2]
    scrubbed_kegs = []

    pages.each do |page|
      kegs = page.css("a.producttitle")
      prices = page.css("span.RegularPrice")
      count = 0

      kegs.each do |keg|
        keg_name = keg.text
        keg_size = keg_name.slice!((/1/ =~ keg_name)..(keg_name.length))
        keg_price = prices[count].text.slice(5..(prices[count].text.length))

        scrubbed_keg = {
          name: keg_name.squish,
          size: keg_size.squish,
          price: keg_price
        }
        scrubbed_kegs << scrubbed_keg

        count += 1
      end
    end
    scrubbed_kegs
  end

end
