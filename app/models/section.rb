class Section < ApplicationRecord
  acts_as_tenant

  belongs_to :department, optional: true
  belongs_to :manager, class_name: 'User', optional: true

  # 課が削除されたら、その課に属するユーザーの所属をnullに
  has_many :users, dependent: :nullify

  validates :name, presence: true, length: { maximum: 100 }
end
