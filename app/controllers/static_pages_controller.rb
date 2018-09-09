class StaticPagesController < ApplicationController
	def index
		@articles = Article.all
		@Article = Article.new

		RunScrap.new.perform
	end 

end
