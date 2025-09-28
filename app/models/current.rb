class Current < ActiveSupport::CurrentAttributes
    attribute :organization
    attribute :user

    # organization_idを取得
    def organization_id
        organization&.id
    end
end