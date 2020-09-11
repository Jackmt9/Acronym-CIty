class Medium < ApplicationRecord
  require 'nokogiri'
  require 'rest-client'
  belongs_to :category

  def self.match_initials(line, initials)
    matched = []
    i = 0

    while i < initials.length
      word = line[i].capitalize

      if word[0] == initials[i]
        matched.push(line[i])
        break if matched.length == initials.length
      else
        matched = []
        break
      end

      i += 1
    end

    if matched.length > 0
      print matched.join(' ')
      return matched.join(' ')
    else
      return false
    end
  end

  def self.query_lyrics(lyrics_array, initials)
    i = 0
    j = 0
    money_index = 0
    while i < initials.length && j < lyrics_array.length
      if lyrics_array[j][0].downcase == initials[i].downcase
        i += 1
        j += 1
      else
        i = 0
        j += 1
      end
    end
    money_index = j - initials.length
    range = { indexAt: money_index, length: initials.length }
    return range
  end

  def self.get_songs(initials)
    Medium.all.each do |medium|
      if medium.url.include?('genius.com') && (medium.id != 38) &&
           (medium.id != 49) && (medium.id != 72) && (medium.id != 167) &&
           (medium.id != 196) && (medium.id != 219) && (medium.id != 225) &&
           (medium.id != 226) && (medium.id != 227) && (medium.id != 247) &&
           (medium.id != 255) && (medium.id != 263) && (medium.id != 273) &&
           (medium.id != 317)
        song_array = []
        request = RestClient.get(medium.url, {})
        html = Nokogiri.HTML(request)
        verse = html.at('.lyrics')
        lyrics = verse.children.text.split(' ')
        range = self.query_lyrics(lyrics, initials)
        # must insert error handling if no match found
        range[:lyrics] = lyrics
        return range
      end
    end
    # print phrase_return
  end
end
