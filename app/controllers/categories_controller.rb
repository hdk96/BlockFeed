class CategoriesController < ApplicationController
    
    def index
    	Categoty.new
    end
    
    def new
    	Categoty.create
  		@Category = Categoty.new(category_params)
  		@Category.save
    end
    
  	private

  	def Category_params
  		params.require(:Category).permit(:name)
 	
  	end

end

