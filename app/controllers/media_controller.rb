class MediaController < ApplicationController
    def query
        search = params[:query]
        initials = self.getInitials(search)
        phrase = getPhrase(initials)
        render json: {result: phrase}
    end

    def getInitials(search)
        search.split(' ').map{|w| w[0].upcase}
    end

    def getPhrase(initials)
        # insert search logic here
        initials
    end

end
