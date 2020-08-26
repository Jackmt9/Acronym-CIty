class Medium < ApplicationRecord
    require 'nokogiri'
    require 'rest-client'
    belongs_to :category
    def self.get_songs
        Medium.all.each do |medium| 
            if medium.url.include?('genius.com')
            request = RestClient.get(medium.url,{})
         html = Nokogiri::HTML(request)
             verse = html.at('.lyrics')
                print verse 
            end
        end
    end
end
