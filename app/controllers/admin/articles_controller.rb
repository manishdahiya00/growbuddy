class Admin::ArticlesController < Admin::AdminController
  before_action :authenticate_user!
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  layout "admin"

  def index
    if params[:q].present?
      query = "%#{params[:q]}%"
      @articles = Article.where("title LIKE :query", query: query).order(created_at: :desc).paginate(page: params[:page], per_page: 15)
    else
      @articles = Article.order(created_at: :desc).paginate(page: params[:page], per_page: 15)
    end
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to admin_articles_path, notice: "Article was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to admin_articles_path, notice: "Article was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to admin_articles_path, notice: "Article was successfully deleted."
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :desc, :category, :image_url, :status, :highlighted, :published_at)
  end
end
