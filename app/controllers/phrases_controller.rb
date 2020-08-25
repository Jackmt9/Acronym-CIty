class PhrasesController < ApplicationController
    def index
        phrases = Phrase.all
        render json: phrases
    end
end
