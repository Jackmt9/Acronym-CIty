class MediaController < ApplicationController
<<<<<<< HEAD
    def query
        search = params[:query]
        render json: {result: search}
=======
    def index
        media = Medium.all
        render json: media
>>>>>>> master
    end
end
