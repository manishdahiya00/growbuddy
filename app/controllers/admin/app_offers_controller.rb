class Admin::AppOffersController < Admin::AdminController
  before_action :set_app_offer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  layout "admin"

  def index
    if params[:q].present?
      query = "%#{params[:q]}%"
      @app_offers = AppOffer.where("offer_name LIKE :query OR identifier LIKE :query", query: query).order(created_at: :desc).paginate(page: params[:page], per_page: 15)
    else
      @app_offers = AppOffer.all.paginate(page: params[:page], per_page: 15).order(created_at: :desc)
    end
  end

  def show
    @offer_events = OfferEvent.where(app_offer_id: @app_offer.id)
    @offer_event = OfferEvent.new
  end

  def new
    @app_offer = AppOffer.new
  end

  def edit
  end

  def create
    @app_offer = AppOffer.new(app_offer_params)
    if @app_offer.save
      redirect_to admin_app_offer_path(@app_offer), notice: "App Offer was successfully created."
    else
      render :new
    end
  end

  def update
    if @app_offer.update(app_offer_params)
      redirect_to admin_app_offer_path(@app_offer), notice: "App Offer was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @app_offer.destroy
    redirect_to admin_app_offers_url, notice: "App Offer was successfully destroyed."
  end

  private

  def set_app_offer
    @app_offer = AppOffer.find(params[:id])
  end

  def app_offer_params
    params.require(:app_offer).permit(:offer_name, :offer_amount, :status, :description, :daily_cap, :whatsapp_link, :insta_offer, :retention_offer, :event_offer, :identifier, :refer_amount, :image_url, :instructions, :action_url, :offer_priority)
  end
end
