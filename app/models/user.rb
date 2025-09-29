class User < ApplicationRecord
  acts_as_tenant
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :organization
  belongs_to :office, optional: true
  belongs_to :department, optional: true
  belongs_to :section, optional: true

  has_many :managed_departments, class_name: "Department", foreign_key: "manager_id"
  has_many :managed_sections, class_name: "Section", foreign_key: "manager_id"
  has_many :sent_appreciations, class_name: "Appreciation", foreign_key: "sender_id"
  has_many :received_appreciations, class_name: "Appreciation", foreign_key: "receiver_id"

  validates :first_name, :last_name, presence: true, length: { maximum: 50 }
  validates :organization_id, presence: true
  validates :employee_id, presence: true, uniqueness: { scope: :organization_id }
  validates :position, length: { maximum: 50 }, allow_blank: true
  validates :bio, length: { maximum: 500 }, allow_blank: true

  enum role: { general: 0, admin: 1 }
  enum status: { inactive: 0, active: 1 }

  scope :active_users, -> { where(status: :active) }
  scope :admins_users, -> { where(role: :admin) }
  scope :general_users, -> { where(role: :general) }

  # 定数定義  
  DAYS_PER_YEAR = 365.25
  DAYS_PER_MONTH = 30.44

  # 同じ組織かどうかを判定
  def same_organization?(other_user)
    self.organization_id == other_user.organization_id
  end

  def full_name
    "#{last_name} #{first_name}"
  end

  # 勤続年数を計算
  def years_of_service
    return 0 if hire_date.blank?
    total_days = (Date.today - hire_date).to_i
    (total_days / DAYS_PER_YEAR).floor
  end

  def months_of_service
    return 0 if hire_date.blank?
    ((Date.today - hire_date) / DAYS_PER_MONTH).round(1)
  end

  def display_years_of_service
    return if hire_date.blank?

    current_date = Date.today
    years = current_date.year - hire_date.year
    months = current_date.month - hire_date.month

    # 日付調整
    if current_date.day < hire_date.day
      months -= 1
    end

    # 月がマイナスの場合の調整
    if months < 0
      years -= 1
      months += 12
    end

    "#{years}年#{months}ヶ月"
  end
end
