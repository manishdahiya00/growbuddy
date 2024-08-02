class Admin::AffiliatesController < Admin::AdminController
  before_action :authenticate_user!
  before_action :set_affiliate, only: [:show]
  layout "admin"

  def index
    if params[:q].present?
      query = "%#{params[:q]}%"
      @affiliates = Affiliate.where("paytm_number LIKE :query OR upi_id LIKE :query OR click_id LIKE :query", query: query).order(created_at: :desc).paginate(page: params[:page], per_page: 15)
    else
      @affiliates = Affiliate.order(created_at: :desc).paginate(page: params[:page], per_page: 15)
    end
  end

  def show
  end

  private

  def set_affiliate
    @affiliate = Affiliate.find(params[:id])
  end
end
