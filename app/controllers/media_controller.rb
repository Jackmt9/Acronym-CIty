class MediaController < ApplicationController
    def query
        search = params[:query]
        initials = self.get_initials(search)
        phrase = get_phrase(initials)
        render json: {result: phrase}
        # byebug
    end

    def index
        media = Medium.all
        render json: media
    end
    def get_initials(search)
        search.split(' ').map{|w| w[0].upcase}
    end

    def get_phrase(initials)
        Medium.get_songs(initials)
        # insert search logic here
            #  song = song.each do |word| 
            #     if word.include?('[') 
            #         hit_open = true
            #         hit_close = false
            #     end
            #     if !!hit_open == !!hit_close
            #         songs_without_nonsense.push(word)
            #      end
            #     if word.include?(']')
            #         hit_close = true
            #     end
            # end
            end
        # songs_without_nonsense.each do |word|
        #     if word[0] == word[0].upcase
        #         new_line = true
        #     end
        #     if new_line 
        #         songs_by_line.push()
        #     end
        #     line.push(word)

        #   songs =  songs.map do |song|
        #         song.split(']')
        #   end
        #   return  songs_without_nonsense
    end

end
