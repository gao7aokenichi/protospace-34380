class Comment < ApplicationRecord
  # 「1対1」のつながりがあることを示すのがbelongs_toメソッド
  belongs_to :user
  belongs_to :prototype
  validates :text, presence: true
end
