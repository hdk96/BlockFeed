class Article < ActiveRecord::Base
    
    validates :title, presence: true, length: { minimum: 3, maximum: 50 }
    validates :description, presence: true, length: { minimum: 10, maximum: 300 }
    validates :link, presence: true, length: { minimum: 10, maximum: 200 }
    validates :image, presence: true, length: { minimum: 10, maximum: 200 }
    

end