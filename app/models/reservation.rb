class Reservation < ApplicationRecord
  # 施設予約のリレーション
  belongs_to :user
  belongs_to :room

  validates :date_check_in, presence: true
  validates :date_check_out, presence: true
  validate :check_dates_relation
  validates :person_num, numericality: { only_integer: true, greater_than: 0 }

  def calculate_the_number_of_stays
    (date_check_out - date_check_in).to_i
  end

  def calculate_payment
    room.price * (date_check_out - date_check_in).to_i * person_num
  end

  def self.reservation_params(send_params)
    send_params.require(:reservation).permit(:date_check_in, :date_check_out, :person_num, :user_id, :room_id)
  end

  private

  def check_dates_relation
    return if date_check_in.nil? || date_check_out.nil?

    errors.add(:date_check_out, 'はチェックイン日より後の日付にしてください') if date_check_in >= date_check_out
  end
end
