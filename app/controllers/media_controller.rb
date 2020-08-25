class MediaController < ApplicationController
    def query
        search = params[:query]
        render json: {result: search}
    end
end
