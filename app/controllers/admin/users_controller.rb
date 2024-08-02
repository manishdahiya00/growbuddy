class Admin::UsersController < Admin::AdminController
  before_action :authenticate_user!
  layout "admin"

  def index
    if params[:q].present?
      query = "%#{params[:q]}%"
      @users = User.where("social_email LIKE :query OR mobile_number LIKE :query", query: query).order(created_at: :desc).paginate(page: params[:page], per_page: 15)
    else
      @users = User.all.paginate(page: params[:page], per_page: 15).order(created_at: :desc)
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
