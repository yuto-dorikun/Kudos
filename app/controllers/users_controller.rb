class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
    @search_term = params[:q]

    # 統計用の変数
    @total_active_users = Current.organization.users.active.count
    @current_month_kudos = 1247
    @active_user_count = Current.organization.users.active.count
    @new_users_this_month = 12

    # 基本的なユーザー取得
    users_scope = Current.organization.users.active.includes(:office, :department, :section)

    # データベースから取得してソート
    all_users = users_scope.order(:office_id, :department_id, :section_id, :last_name)

    # 検索処理
    if @search_term.present?
      @users = all_users.select { |user| user.full_name.include?(@search_term) }
    end

    # 組織階層表示用
    @offices = Current.organization.offices.includes(
      departments: { sections: :users }
    ).order(is_headquarters: :desc, name: :asc)
  end

  def show
  end

  def search
    redirect_to users_path(q: params[:q])
  end

  def activity
    @user = User.find(params[:id])

    # 送信したKudos
    @sent_appreciations = Appreciation.where(sender_id: @user.id, organization_id: Current.organization.id)
                                      .includes(:sender, :receiver)
                                      .order(created_at: :desc)
                                      .page(params[:sent_page]).per(10)

    # 受信したKudos
    @received_appreciations = Appreciation.where(receiver_id: @user.id, organization_id: Current.organization.id)
                                          .includes(:sender, :receiver)
                                          .order(created_at: :desc)
                                          .page(params[:received_page]).per(10)
  end

  private

  def set_user
    @user = User.find(params[:id])
    # 異なる組織のユーザーは見れない
    unless @user.same_organization?(current_user)
      redirect_to users_path, alert: "アクセス権限がありません"
    end
  end
end
