require 'open-uri'

class Scraper

  def get_kegs
    url1 = 'http://www.hazelsboulder.com/main.asp?request=search&type=B&sel_category=20977&user1=15.5+GALLON&pageNo=1'
    url2 = 'http://www.hazelsboulder.com/main.asp?request=search&type=B&sel_category=20977&user1=15.5+GALLON&pageNo=2'
    page1 = Nokogiri::HTML(open(url1))
    page2 = Nokogiri::HTML(open(url2))

    pages = [page1, page2]
    scrubbed_kegs = []

    pages.each do |page|
      kegs = page.css('a.producttitle')
      prices = page.css('span.RegularPrice')
      count = 0

      kegs.each do |keg|
        keg_name = keg.text
        keg_size = keg_name.slice!((/1/ =~ keg_name)..(keg_name.length))
        keg_price = prices[count].text.slice(6..(prices[count].text.length))

        scrubbed_keg = {
          name: name_cleanup(keg_name.squish),
          size: size_cleanup(keg_size.squish),
          price: keg_price
        }
        scrubbed_kegs << scrubbed_keg

        count += 1
      end
    end
    scrubbed_kegs
  end

  private
    def name_cleanup(name)
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

    def size_cleanup(size)
      case size
        when '15G Keg'
          '15.5G Keg'
        when '15.5 Keg'
          '15.5G Keg'
      else
        size
      end
    end

end
