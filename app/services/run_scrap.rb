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
	def save
		all_titles	 	= []
		all_link		= []
		all_images   	= []
		all_content  	= []
		all_create_time = []
	
		all_titles	 	= get_articles_title(@doc)
		all_link		= get_articles_url(@doc)
		all_images   	= get_articles_img(@doc)
		all_content  	= get_articles_content(@doc)
		all_create_time = get_creat_time(@doc)

		@articles_length = all_titles.length

		for i in 0..@articles_length

			if (all_titles[i] =~ /[a-zA-Z]/  and all_content[i] =~ /[a-zA-Z]/ ) 
				Article.create(title: all_titles[i], description: all_content[i], link: all_link[i], image: all_images[i], created_at: all_create_time[i])
			end
		end 
	end

	def perform
		Article.all.destroy_all
		save
	end 
end 