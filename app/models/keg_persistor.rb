class KegPersistor

  def initialize(kegs)
    @kegs = kegs
  end

  def persist
    result = {
      added: 0,
      updated: 0,
      deleted: 0,
    }
    keg_names = []

    @kegs.each do |keg|
      keg_names << keg[:name]

      db_keg = Keg.find_or_initialize_by(
        name: keg[:name],
      )

      db_keg.attributes = {
        size: keg[:size],
        price: keg[:price],
        sale_price: keg[:sale_price],
        url: keg[:url],
        active: true
      }

      if db_keg.new_record?
        result[:added] += 1
        db_keg.save
      elsif db_keg.changed?
        result[:updated] += 1
        db_keg.save
      end
    end

    Keg.all.each do |db_keg|
      unless keg_names.include?(db_keg.name)
        if db_keg.active == true
          result[:deleted] += 1
          db_keg.update(active: false)
        end
      end
    end

    result
  end

end
