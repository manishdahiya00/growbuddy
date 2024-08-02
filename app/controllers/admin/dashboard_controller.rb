module Admin
  class DashboardController < Admin::AdminController
    before_action :authenticate_user!
    layout "admin"

    def index
      @users = User.count
      @app_banners = AppBanner.count
      @articles = Article.count
      @affiliates = Affiliate.count
      @referrers = Referrer.count
      @postbacks = Postback.count
    end
  end
end
