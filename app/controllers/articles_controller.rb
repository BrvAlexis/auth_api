class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]
  before_action :check_owner, only: %i[ update destroy ]
  before_action :set_article, only: %i[ show update destroy ]

  # GET /articles
  def index
    @articles = Article.where(private: false).or(Article.where(user: current_user))

    render json: @articles
  end

  # GET /articles/1
  def show
    if @article.private? && @article.user != current_user
      render json: { error: 'Cet article est privé.' }, status: :forbidden
    else
      render json: @article
    end
  
  end

  # POST /articles
  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Vérifie si l'utilisateur actuel est le propriétaire de l'article
    def check_owner
      unless current_user == @article.user
        render json: { error: 'Vous n\'êtes pas autorisé à modifier ou supprimer cet article.' }, status: :forbidden
      end
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :private)
    end

    # Verify if a user is authenticated
    def authenticate_user!
      render json: { error: 'Vous devez être connecté pour effectuer cette action.' }, status: :unauthorized unless user_signed_in?
    end
end
