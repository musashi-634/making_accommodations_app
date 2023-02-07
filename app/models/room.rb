class Room < ApplicationRecord
  # 施設登録のリレーション
  belongs_to :user
  # 施設予約のリレーション
  has_many :reservations
  has_many :users, through: :reservations

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, numericality: { only_integer: true }
  validates :address, presence: true

  # image関係
  has_one_attached :image
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: 'は有効なフォーマットではありません' },
                    size: { less_than: 1.megabytes, message: 'のファイルサイズを1MBより小さくしてください' }

  def self.search_rooms(address, keyword)
    Room.where('address LIKE ?', "%#{address}%")
        .where('name LIKE ? OR introduction LIKE ?', "%#{keyword}%", "%#{keyword}%")
  end
end
