class StaticPagesController < ApplicationController
	def index
		@articles = Article.all
		@Article = Article.new
	end 
end
