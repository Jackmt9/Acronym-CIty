class MediaController < ApplicationController
    def index
        media = Medium.all
        render json: media
    end
end
