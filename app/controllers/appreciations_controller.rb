class AppreciationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @appreciation = Appreciation.new
    @users = User.where(organization_id: Current.organization.id)
                 .where.not(id: current_user.id)
                 .includes(:office, :department, :section)
                 .order(:office_id, :department_id, :section_id, :name)
    @offices = Office.where(organization_id: Current.organization.id)
                     .includes(departments: { sections: :users })
                     .left_joins(departments: { sections: :users })
                     .group('offices.id')
                     .order('COUNT(users.id) DESC')

    # 最近送信したユーザー
    @recent_recipients = User.joins(:received_appreciations)
                             .where(appreciations: { sender_id: current_user.id, organization_id: Current.organization.id })
                             .select('users.*, MAX(appreciations.created_at) as last_sent_at')
                             .group('users.id')
                             .order('last_sent_at DESC')
                             .limit(5)
  end

  def create
    @appreciation = Appreciation.new(appreciation_params)
    @appreciation.sender = current_user
    @appreciation.organization = Current.organization

    respond_to do |format|
      if @appreciation.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "appreciation_form",
            partial: "appreciations/success_message"
          )
        end
        format.html { redirect_to new_appreciation_path, notice: "Kudosを送信しました！" }
      else
        @users = User.where(organization_id: Current.organization.id)
                     .where.not(id: current_user.id)
                     .includes(:office, :department, :section)
                     .order(:office_id, :department_id, :section_id, :name)
        @offices = Office.where(organization_id: Current.organization.id)
                         .includes(departments: { sections: :users })
                         .left_joins(departments: { sections: :users })
                         .group('offices.id')
                         .order('COUNT(users.id) DESC')

        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "appreciation_form",
            partial: "appreciations/form",
            locals: { appreciation: @appreciation, users: @users, offices: @offices }
          )
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def index
    @appreciations = Appreciation.where(organization_id: Current.organization.id)
                                  .includes(:sender, :receiver)
                                  .order(created_at: :desc)
                                  .page(params[:page]).per(20)
  end

  private

  def appreciation_params
    params.require(:appreciation).permit(:receiver_id, :category, :message, :is_public)
  end
end