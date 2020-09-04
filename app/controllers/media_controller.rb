class MediaController < ApplicationController
    def query
        search = params[:query]
        render json: {result: search}
    end

    def index
        media = Medium.all
        render json: media
    end
end
