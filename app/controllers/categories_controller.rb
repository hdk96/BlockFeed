class CategoriesController < ApplicationController
    
    def index
    	Categoty.new
    end
    
    def new
    	Categoty.create
  		@Categoty = Categoty.new(category_params)
  		@Categoty.save
    end
    
  	private

  	def Categoty_params
  		params.require(:Categoty).permit(:name)
 	
  	end

end

