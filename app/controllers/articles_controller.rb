class ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: articles
  end

  def show
    session[:page_views] ||= 0
    session[:page_views] += 1

    if session[:page_views] < 3
      article = Article.find(params[:id])
      render json: {
        id: article.id,
        title: article.title,
        minutes_to_read: article.minutes_to_read,
        author: article.author,
        content: "Content #{article.id}\nparagraph 1"
      }
    else
      render json: { error: "Maximum pageview limit reached" }, status: :unauthorized
    end
  end
end