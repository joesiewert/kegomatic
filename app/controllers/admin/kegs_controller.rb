class Admin::KegsController < ApplicationController
  def sync
    scraper = Scraper.new
    kegs = scraper.get_kegs
    saved_kegs = KegPersistor.new(kegs).persist
    redirect_to(
      admin_index_path,
      notice: "Found #{plural_kegs(kegs.length)} at hazelsboulder.com | Kegomatic - Added: #{plural_kegs(saved_kegs[:added])} | Updated: #{plural_kegs(saved_kegs[:updated])} | Deleted: #{plural_kegs(saved_kegs[:deleted])}"
    )
  end

  private
    def plural_kegs(count)
      view_context.pluralize(count, 'keg')
    end
end
