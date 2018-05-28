class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  #has_many :reservations, :through => :listings

  def city_openings(start, finish)
    date_range = (start.to_datetime..finish.to_datetime).to_a
    self.listings.select { |listing| (listing.dates_reserved & date_range).empty?}
  end

  def reservation_count
    count = 0
    self.listings.each do |listing|
      count += listing.reservation_count
    end
    count
  end

  def listing_count
    self.listings.count
  end

  def reservation_ratio
    if listing_count > 0
      (reservation_count.to_f / listing_count.to_f)
    end
  end

  def self.highest_ratio_res_to_listings
    self.all.sort_by {|city| city.reservation_ratio}.last
  end

  def self.most_res
    self.all.sort_by {|city| city.reservation_count}.last
  end

end

