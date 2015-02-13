require 'rails_helper'

describe KegPersistor do

  describe '#persist' do
    it 'adds kegs that are not already in the db and returns added count' do
      scraped_kegs = [
        {:name=>"Avery IPA", :size=>"15.5G Keg", :price=>"128.98", :sale_price=>nil, :url=>"http://www.hazelsboulder.com/sku130993.html"},
        {:name=>"New Belgium Fat Tire", :size=>"15.5G Keg", :price=>"142.98", :sale_price=>nil, :url=>"http://www.hazelsboulder.com/sku130254.html"},
        {:name=>"Odell 5 Barrel Pale Ale", :size=>"15.5G Keg", :price=>"132.98", :sale_price=>nil, :url=>"http://www.hazelsboulder.com/sku132624.html"}
      ]

      result = KegPersistor.new(scraped_kegs).persist

      expect(Keg.all.count).to eq(3)
      expect(result[:added]).to eq(3)
      expect(Keg.first[:name]).to eq(scraped_kegs[0][:name])
      expect(Keg.first[:size]).to eq(scraped_kegs[0][:size])
      expect(Keg.first[:price]).to eq(scraped_kegs[0][:price].to_f)
      expect(Keg.first[:sale_price]).to eq(scraped_kegs[0][:sale_price])
      expect(Keg.first[:url]).to eq(scraped_kegs[0][:url])
    end

    it 'updates data for kegs that are already in the db and returns updated count' do
      keg = Keg.create!(
        name: 'Avery IPA',
        size: '15.5G Keg',
        price: '128.98',
        sale_price: nil,
        url: 'http://www.hazelsboulder.com/sku130993.html'
      )

      scraped_keg = [
        {:name=>"Avery IPA", :size=>"15.5G Keg", :price=>"158.98", :sale_price=>"119.98", :url=>"http://www.hazelsboulder.com/sku130993.html"}
      ]

      result = KegPersistor.new(scraped_keg).persist

      expect(Keg.all.count).to eq(1)
      expect(result[:updated]).to eq(1)
      expect(Keg.first[:price]).to eq(scraped_keg[0][:price].to_f)
      expect(Keg.first[:sale_price]).to eq(scraped_keg[0][:sale_price].to_f)
    end

    it 'deletes kegs from the db that are no longer in the scraper list and returns deleted count' do
      keg = Keg.create!(
        name: 'Avery IPA',
        size: '15.5G Keg',
        price: '128.98',
        sale_price: nil,
        url: 'http://www.hazelsboulder.com/sku130993.html'
      )

      result = KegPersistor.new([]).persist

      expect(Keg.find_by_id(keg.id)).to be_nil
      expect(result[:deleted]).to eq(1)
    end

  end

end
