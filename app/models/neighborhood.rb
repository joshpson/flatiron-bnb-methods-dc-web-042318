class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  def neighborhood_openings(start, finish)
    date_range = (start.to_datetime..finish.to_datetime).to_a
    self.listings.select { |listing| (listing.dates_reserved & date_range).empty?}
  end


end
