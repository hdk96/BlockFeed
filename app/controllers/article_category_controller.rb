class ArticleCategoryController < ApplicationController
	def new
		ArticleCategory.new
	end

	def create
		ArticleCategory.create
		@article = ArticleCategory.new(ac_params)
		@article.save
	end

	private

	def ac_params
		params.require(:articlecategory).permit(:article_id, :category_id)

	end
end
