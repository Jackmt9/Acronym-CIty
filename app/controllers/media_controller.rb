class MediaController < ApplicationController
    def query
        search = params[:query]
        initials = self.getInitials(search)
        render json: {result: initials}
    end

    def getInitials(search)
        search.split(' ').map{|w| w[0].upcase}
    end

end
