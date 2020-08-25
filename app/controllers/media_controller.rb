class MediaController < ApplicationController
    def query
        render json: {result: "hit"}
    end
end
