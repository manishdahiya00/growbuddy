class Admin::ReferrersController < Admin::AdminController
  before_action :authenticate_user!
  layout "admin"

  def index
    if params[:q].present?
      query = "%#{params[:q]}%"
      @referrers = Referrer.where("paytm_number LIKE :query OR upi_id LIKE :query OR click_id LIKE :query", query: query).paginate(page: params[:page], per_page: 15)
    else
      @referrers = Referrer.paginate(page: params[:page], per_page: 15).order(created_at: :desc)
    end
  end

  def show
    @referrer = Referrer.find(params[:id])
  end
end
