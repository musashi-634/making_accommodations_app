class Room < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, numericality: { only_integer: true }
  validates :address, presence: true

  # image関係
  has_one_attached :image
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: 'は有効なフォーマットではありません' },
                    size: { less_than: 1.megabytes, message: 'のファイルサイズを1MBより小さくしてください' }
end
