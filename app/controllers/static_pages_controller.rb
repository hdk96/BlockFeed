class StaticPagesController < ApplicationController
	def index
		@articles = Article.all
		@Article = Article.new

		@categories = ArticleCategory.all
		@category = ArticleCategory.new

		@articles_categories = Category.all
		@article_category = Category.new

		RunScrap.new.perform
	end 

end
