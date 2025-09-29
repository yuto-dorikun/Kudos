class Appreciation < ApplicationRecord
  acts_as_tenant

  belongs_to :organization
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"

  enum category: {
    teamwork: 0,
    innovation: 1,
    leadership: 2,
    dedication: 3,
    quality: 4,
    customer_focus: 5,
    growth: 6,
    positivity: 7
  }

  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :category, presence: true
  validates :message, presence: true, length: { maximum: 500 }
  validates :is_public, inclusion: { in: [true, false] }
  validates :organization_id, presence: true
  validate :cannot_send_to_self
  validate :same_organization_only

  private
  def cannot_send_to_self
    if self.sender_id == self.receiver_id
      errors.add(:base, "自分には送信できません")
    end
  end

  def same_organization_only
    if sender.organization_id != receiver.organization_id
      errors.add(:base, "送信者と受信者は同じ組織でなければなりません")
    end
  end
end
