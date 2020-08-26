class Medium < ApplicationRecord
    belongs_to :category
    include HTTParty
    def self.get_songs
        Medium.all.each do |medium| 
            if medium.url.include?('genius.com')
                body = HTTParty.get(medium.url).body
                print body 
            end
        end
    end

end
