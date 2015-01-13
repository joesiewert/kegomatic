require 'open-uri'

class Scraper

  def get_kegs
    url1 = 'http://www.hazelsboulder.com/main.asp?request=search&type=B&sel_category=20977&user1=15.5+GALLON&pageNo=1'
    url2 = 'http://www.hazelsboulder.com/main.asp?request=search&type=B&sel_category=20977&user1=15.5+GALLON&pageNo=2'
    urls = [url1, url2]
    kegs = []

    urls.each do |url|
      page = Nokogiri::HTML(open(url))
      scraped_kegs = page.css("#rt-col table:nth-child(9) tr[valign='top'] table[width='100%']")

      scraped_kegs.each do |scraped_keg|
        keg = {
          name: name_cleanup(scraped_keg.css('.producttitle').text),
          size: size_cleanup(scraped_keg.css('.producttitle').text),
          price: price_cleanup(scraped_keg.css('.RegularPrice').text),
          sale_price: price_cleanup(scraped_keg.css('.SalePrice').text),
          url: scraped_keg.css('a:first-of-type')[0]['href']
        }
        kegs << keg
      end
    end
    kegs
  end

  private
    def name_cleanup(scraped_name)
      name = scraped_name[0..(/1/ =~ scraped_name)-1].squish
      case name
        when 'Avery Ellies Brown'
          'Avery Ellie’s Brown Ale'
        when 'Boulder Buff Gold'
          'Boulder Buffalo Gold'
        when 'Coors Original'
          'Coors Banquet'
        when 'Deschutes Freshsqueeze IPA'
          'Deschutes Fresh Squeezed IPA'
        when 'Deschutes Mirror'
          'Deschutes Mirror Pond Pale Ale'
        when 'Guinness Stout'
          'Guinness'
        when 'Left Hand Sawtooth'
          'Left Hand Sawtooth Ale'
        when 'Odells 5 Barrel'
          'Odell 5 Barrel Pale Ale'
        when 'Odells 90 Shilling'
          'Odell 90 Shilling Ale'
        when 'Odells Easy Street'
          'Odell Easy Street Wheat'
        when 'Odells IPA'
          'Odell IPA'
        when 'Odells Levity Ale'
          'Odell Levity Amber Ale'
        when 'Oskar Blues Dales Pale'
          'Oskar Blues Dale’s Pale Ale'
        when 'Oskar Blues Mama Pils'
          'Oskar Blues Mama’s Little Yella Pils'
        when 'Pabst Blue'
          'Pabst Blue Ribbon'
        when 'Sierra Nevada Pale'
          'Sierra Nevada Pale Ale'
      else
        name
      end
    end

    def size_cleanup(scraped_size)
      size = scraped_size[(/1/ =~ scraped_size)..scraped_size.length].squish
      case size
        when '15G Keg'
          '15.5G Keg'
        when '15.5 Keg'
          '15.5G Keg'
      else
        size
      end
    end

    def price_cleanup(scraped_price)
      if scraped_price.empty?
        nil
      else
        scraped_price[(/\$/ =~ scraped_price)+1..scraped_price.length].squish
      end
    end

end
