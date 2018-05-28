class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  def dates_reserved
    (self.checkin..self.checkout).to_a
  end


end
