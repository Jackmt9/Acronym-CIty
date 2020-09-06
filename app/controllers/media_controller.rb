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
        # insert search logic here
            songs = Medium.get_songs.split('/sse')

        #   songs =  songs.map do |song|
        #         song.split(']')
        #   end
          return  songs
    end

end
