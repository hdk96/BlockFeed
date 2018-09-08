class ArticlesController < ApplicationController

  	def new
  		Article.new
  	end

  	def create
  		Article.create
  		@article = Article.new(article_params)
  		@article.save
  	end

  	private

  	def article_params
  		params.require(:article).permit(:title, :description, :created_at, :link, :image)
 	
  	end
end
