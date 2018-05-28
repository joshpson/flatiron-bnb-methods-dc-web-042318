class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  validates :address,:listing_type,:title,:description,:price,:neighborhood, presence: true
  after_create :set_host_active
  after_destroy :set_host_inactive

  def dates_reserved
    self.reservations.map { |reservation| reservation.dates_reserved }.flatten
  end

  def reservation_count
    self.reservations.count
  end

  def set_host_active
    self.host.update(host: true)
  end

  def set_host_inactive
    if self.host.listings.empty?
      self.host.update(host: false)
    end
  end

  def average_review_rating
    self.reviews.average(:rating)
  end

end
