class MediaController < ApplicationController
  def query
    search = params[:query]
    initials = self.get_initials(search)
    phrase = self.get_phrase(initials)
    render json: { result: phrase }
  end

  def index
    media = Medium.all
    render json: media
  end
  def get_initials(search)
    search.split(' ').map { |w| w[0].upcase }
  end

  def get_phrase(initials)
    Medium.get_songs(initials)
  end
end
