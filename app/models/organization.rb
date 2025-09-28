class Organization < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }

  # ユーザーがいる場合は削除できない
  has_many :users, dependent: :restrict_with_exception

  # 組織が削除されたら、その組織に属する全てのデータも削除
  has_many :offices, dependent: :destroy
  has_many :departments, dependent: :destroy
  has_many :sections, dependent: :destroy
end
