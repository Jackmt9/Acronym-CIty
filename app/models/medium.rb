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
             lyrics = verse.children
             lyrics
            #  verseArray = verse.split('pending-editorial-actions-count')
                print lyrics.text
            end
        end
    end

    def self.seed_beatles
        request = RestClient.get('https://www.beatlesbible.com/songs/')
        html = Nokogiri::HTML(request)
       song_box = html.at(".post-7")
       song_titles = song_box.children.children.children.children
        song_titles_2 = song_titles.to_s().split('<li><a')
        song_titles_3 = song_titles_2.filter do |song_title| 
        song_title.include?('/songs/')
        end
        song_titles_4 = []
        song_titles_3.each do |song_title|
                song_titles_4 << song_title.split('/')[2]
        end
        song_titles_4.shift()
        song_titles_4.shift()
        song_titles_4.each do |song_name|
       song_name = Medium.create(name: `#{song_name}`, author: 'The Beatles', category_id: 1, url: `https://genius.com/The-beatles-#{song_name}-lyrics`)
        end
    end
end
