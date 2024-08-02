class Admin::PostbacksController < Admin::AdminController
  before_action :authenticate_user!
  layout "admin"

  def index
    if params[:q].present?
      query = "%#{params[:q]}%"
      @postbacks = Postback.where("click_id LIKE :query", query: query).order(created_at: :desc).paginate(page: params[:page], per_page: 15)
    else
      @postbacks = Postback.order(created_at: :desc).paginate(page: params[:page], per_page: 15)
    end
  end
end
