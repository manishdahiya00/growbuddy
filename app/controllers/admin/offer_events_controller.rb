class Admin::OfferEventsController < Admin::AdminController
  before_action :authenticate_user!
  before_action :set_offer_event, only: [:show, :edit, :update, :destroy]
  layout "admin"

  def index
    @offer_events = OfferEvent.order(created_at: :desc).paginate(page: params[:page], per_page: 15)
  end

  def show
  end

  def new
    @offer_event = OfferEvent.new
  end

  def create
    @offer_event = OfferEvent.new(offer_event_params)
    if @offer_event.save
      redirect_to admin_app_offer_path(@offer_event.app_offer_id), notice: "Offer event was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @offer_event.update(offer_event_params)
      redirect_to admin_app_offer_path(@offer_event.app_offer_id), notice: "Offer event was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @offer_event.destroy
    redirect_to admin_app_offer_path(params[:app_offer_id]), notice: "Offer event was successfully destroyed."
  end

  private

  def set_offer_event
    @offer_event = OfferEvent.find_by(id: params[:id], app_offer_id: params[:app_offer_id])
    unless @offer_event
      flash[:alert] = "Offer Event not found."
      redirect_to admin_app_offers_path
    end
  end

  def offer_event_params
    params.require(:offer_event).permit(:event_title, :event_amount, :pay_type, :event_order, :app_offer_id)
  end
end
