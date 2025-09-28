class Office < ApplicationRecord
  acts_as_tenant

  # 事業所が削除されたら、その事業所に属する部署を削除、ユーザーの所属をnullに
  has_many :departments, dependent: :destroy
  has_many :users, dependent: :nullify

  validates :name, presence: true, length: { maximum: 100 }
  validates :is_headquarters, inclusion: { in: [true, false] }

  scope :headquarters, -> { where(is_headquarters: true) }
  scope :branches, -> { where(is_headquarters: false) }
end
