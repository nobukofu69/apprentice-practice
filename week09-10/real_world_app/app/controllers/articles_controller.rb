class ArticlesController < ApplicationController
  # Create Article
  def create
    @article = Article.new(article_params)
    if @article.save
      render json: { "article":@article.to_json }, status: :created
    else
      render json: { error: 'Failed to create todo' }, status: :unprocessable_entity
    end
  end

  # Get Article
  def show
    @article = Article.find_by(slug: params[:slug])
    if @article
      render json: { "article":@article.to_json }, status: :ok
    else
      render json: { "article":@article.to_json }, status: :not_found
    end
  end

  # Update Article
  def update
    @article = Article.find_by(slug: params[:slug])
    if @article.update(article_params)
      render json: { "article":@article.to_json }, status: :ok
    else
      render json: { error: 'Failed to create todo' }, status: :unprocessable_entity
    end
  end

  # Delete Article
  def destroy
    @article = Article.find_by(slug: params[:slug])
    if @article.destroy
      head :no_content
    else
      render json: { error: 'Failed to delete the article' }, status: :unprocessable_entity
    end
  end

  # ストロングパラメータ
  private
  def article_params
    params.require(:article).permit(:title, :description, :body)
  end
end