class User < ApplicationRecord
  acts_as_tenant
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :organization

  validates :first_name, :last_name, presence: true, length: { maximum: 50 }
  validates :organization_id, presence: true

  # 同じ組織かどうかを判定
  def same_organization?(other_user)
    self.organization_id == other_user.organization_id
  end
end
