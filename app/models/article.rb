class Article < ActiveRecord::Base
    has_many :article_categories
    has_many :categories, through: :article_categories
    validates :title, presence: true, length: { minimum: 10, maximum: 255 }
    validates :description, presence: true, length: { minimum: 10, maximum: 300 }
    validates :link, presence: true, length: { minimum: 5, maximum: 255 }
    validates :image, presence: true, length: { minimum: 5, maximum: 255}


end