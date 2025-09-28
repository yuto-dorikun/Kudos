class Department < ApplicationRecord
  acts_as_tenant

  belongs_to :office, optional: true
  belongs_to :manager, class_name: 'User', optional: true

  # 部署が削除されたら、その部署に属する課を削除、ユーザーの所属をnullに
  has_many :sections, dependent: :destroy
  has_many :users, dependent: :nullify

  validates :name, presence: true, length: { maximum: 100 }
end
