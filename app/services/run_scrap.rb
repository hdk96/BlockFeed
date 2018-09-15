#! /usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri' 
require 'pry'
require 'uri'

class RunScrap

	def initialize
		@doc = Nokogiri::HTML(open('https://www.crypto-france.com'))
	end

#-----------------------------------------------------------------------------------
	def get_articles_title(page)
		@articles_title = []
		idx = 0
		page.xpath('//div[@class="herald-main-content col-lg-9 col-md-9 col-mod-main"]//h2').each do |title|
			@articles_title[idx] = title.content
			idx += 1
		end 

		t = @articles_title.length
		@articles_title = @articles_title[1..t]

		return @articles_title
	end 
#-----------------------------------------------------------------------------------
	def get_articles_url(page)
		@articles_url = []
		idx = 0
		page.xpath('//h2[@class="entry-title h3"]//a').each do |link|
			@articles_url[idx] = link["href"] 
			idx += 1
		end 
		return @articles_url
	end 
#-----------------------------------------------------------------------------------
	def get_articles_img(page)
		@articles_img = []
		idx = 0
		page.xpath('//img[@class="attachment-herald-lay-b size-herald-lay-b wp-post-image"]').each do |img_link|
			@articles_img[idx] = img_link["src"] 
			idx += 1
		end 
		return @articles_img
	end 
#-----------------------------------------------------------------------------------
	def get_articles_content(page)
		@articles_content = []
		idx = 0
		page.xpath('//div[@class="entry-content"]//p').each do |value|
			@articles_content[idx] = value.content
			idx += 1
		end 
		return @articles_content
	end 
#-----------------------------------------------------------------------------------
	def get_creat_time(page)
		@article_creat_at = []
		idx = 0
		page.xpath('//span[@class="updated"]').each do |creation_date|
			@article_creat_at[idx] = creation_date.content
			idx += 1
		end 
		return @article_creat_at
	end
#-----------------------------------------------------------------------------------
def get_articles_category(page)
	@articles_categories = []
	@db_title = get_articles_title(@doc)
	idx = 0

	page.xpath('//div[@class="entry-header"]//span[@class="meta-category"]//a').each do |category|

		@test = page.xpath('//div[@class="herald-post-thumbnail herald-format-icon-middle"]//a')
		
 		if  category.content != nil and category.content != 0 and @test[idx] != nil

 			@regEx = @test[idx]["title"].scan(/.*?<span.*?>(.*?)<\/span>.?/).join("")
	 		@title_test = @test[idx]["title"].sub(/<span class="(.+?)">(.+?)<\/span>/,@regEx)

			@title_test = @title_test[0..19]
			@db_title[idx + 1] = @db_title[idx][0..19]

 			if (@title_test == @db_title[idx + 1] and idx > 0)
				@articles_categories[idx] = "#{articles_categories[idx - 1]} #{category.content}"
			else 
				@articles_categories[idx] = category.content	
			end  

		end

		idx += 1
	end 


	return @articles_categories
end
#-----------------------------------------------------------------------------------
	def save
		all_titles	 	= []
		all_link		= []
		all_images   	= []
		all_content  	= []
		all_create_time = []
		all_categories 	= []
	
		all_titles	 	= get_articles_title(@doc)
		all_link		= get_articles_url(@doc)
		all_images   	= get_articles_img(@doc)
		all_content  	= get_articles_content(@doc)
		all_create_time = get_creat_time(@doc)
		all_category 	= get_articles_category(@doc)

		@articles_length = all_titles.length

		for i in 0..@articles_length

			if (all_titles[i] =~ /[a-zA-Z]/  and all_content[i] =~ /[a-zA-Z]/ ) 
				Article.create(title: all_titles[i], description: all_content[i], link: all_link[i], image: all_images[i], created_at: all_create_time[i])
				article = Article.last

				Category.create(name: all_categories[i])
				category = Category.last

				ArticleCategory.create(article_id: article.id, category_id:category.id)
			end
		end 
	end

	def perform
		Category.create(name: "fooooobaaaar")
		ArticleCategory.create(article_id: 1, category_id: 2)
		
		Article.all.destroy_all
		Category.all.destroy_all
		ArticleCategory.all.destroy_all
		save
	end 
end 