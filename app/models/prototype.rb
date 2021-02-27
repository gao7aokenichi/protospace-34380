class Prototype < ApplicationRecord
  belongs_to :user
  # レコードとファイルを1対1の関係で紐づける
  has_one_attached :image
 # dependentオプションに:destroyを指定した場合、親モデルが削除されたときに、関連付けしている子モデルも削除されます。
  has_many :comments, dependent: :destroy

  validates :title, presence: true 
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :image, presence: true
end
