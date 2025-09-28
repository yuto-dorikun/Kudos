class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # マルチテナント用のメソッド
  def self.acts_as_tenant
    default_scope { where(organization_id: Current.organization_id) if Current.organization_id.present? }
    belongs_to :organization
    validates :organization_id, presence: true
  end
end
