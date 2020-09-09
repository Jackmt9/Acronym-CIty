class Medium < ApplicationRecord
    require 'nokogiri'
    require 'rest-client'
    belongs_to :category

    def self.match_initials(line, initials)
        matched = []
        i = 0
        while i < initials.length do
            # print line[i][0]
            # print initials[i]

           word = line[i].capitalize 
                if word[0] == initials[i]
                    matched.push(line[i])
                    if matched.length == initials.length
                        
                        break 
                    end
                else 
                     matched = []
                 break
                 end
            i += 1
        end
        if matched.length > 0
            print matched.join(" ")
        return matched.join(" ")
        else
         return false
        end
    end


    def self.query_lyrics(song_array, initials)

        ideal_length = initials.length
        # want to make a priority list, which consists of all the sentences which are exactly the same length as the initials array,
        # then decrement the length each time until we either find something or the whole song fails
        # if the initials array is too long, then combine every two arrays and query the new Arrays with recursion
        lines_at_work = song_array.select do |line|
            line.length >= ideal_length
        end
        
        money_line = ''
        lines_at_work = lines_at_work.sort { |a,b| a.length <=> b.length }
        phrase_return = []
       lines_at_work.each do |line|
        phrase = self.match_initials(line, initials)
        if !!phrase
            print "hit" 
            phrase_return.push(phrase, line)

        end
       end
       return phrase_return.join('') 
    #    + "(#{money_line})"
    end

    def self.trim_array(array)
        new_array = array.select do |line|
                !line.include?('[' && ']')
         end

         new_array =  new_array.map do |line|
            line.split(' ')
         end
         return new_array
    end
        def self.get_songs(initials)
            phrase_return = ''
            # while phrase_return === ''
            Medium.all.each do |medium|
                if medium.url.include?('genius.com') && (medium.id != 38) && (medium.id != 49) && (medium.id != 72) && (medium.id != 167) && (medium.id != 196) && (medium.id != 219) && (medium.id != 225) && (medium.id != 226) && (medium.id != 227) && (medium.id != 247) && (medium.id != 255) && (medium.id != 263) && (medium.id != 273) && (medium.id != 317)
                    song_array = []
                    request = RestClient.get(medium.url,{})
                    html = Nokogiri::HTML(request)
                    verse = html.at('.lyrics')
                    lyrics = verse.children
                        lyrics.text.each_line do |line|
                        song_array.push(line)
                        end
                    song_array = self.trim_array(song_array)
                    phrase_return = self.query_lyrics(song_array, initials)
                end
                if phrase_return.length > 0
                    return phrase_return + medium.name
                end
                # end
            end
            print phrase_return 
            byebug
        end
        

    # def self.seed_beatles
    #     beatles_songs = ["12-bar-original", "a-day-in-the-life", "a-hard-days-night", "a-shot-of-rhythm-and-blues", "a-taste-of-honey", "across-the-universe", "act-naturally", "aint-she-sweet", "all-ive-got-to-do", "all-my-loving", "all-things-must-pass", "all-together-now", "all-you-need-is-love", "and-i-love-her", "and-your-bird-can-sing", "anna-go-to-him", "another-girl", "any-time-at-all", "ask-me-why", "baby-its-you", "baby-youre-a-rich-man", "babys-in-black", "back-in-the-ussr", "bad-boy", "bad-to-me", "the-ballad-of-john-and-yoko", "beautiful-dreamer", "because", "being-for-the-benefit-of-mr-kite", "besame-mucho", "birthday", "blackbird", "blue-jay-way", "blue-moon", "boys", "can-you-take-me-back", "cant-buy-me-love", "carnival-of-light", "carol", "carry-that-weight", "cayenne", "chains", "child-of-nature", "christmas-time-is-here-again", "circles", "clarabella", "come-and-get-it", "come-together", "the-continuing-story-of-bungalow-bill", "cry-baby-cry", "cry-for-a-shadow", "crying-waiting-hoping", "dear-prudence", "devil-in-her-heart", "dig-a-pony", "dig-it", "dizzy-miss-lizzy", "do-you-want-to-know-a-secret", "doctor-robert", "dont-bother-me", "dont-ever-change", "dont-let-me-down", "dont-pass-me-by", "drive-my-car", "eight-days-a-week", "eleanor-rigby", "the-end", "etcetera", "every-little-thing", "everybodys-got-something-to-hide-except-me-and-my-monkey", "fixing-a-hole", "flying", "the-fool-on-the-hill", "for-no-one", "for-you-blue", "free-as-a-bird", "from-me-to-you", "get-back", "getting-better", "girl", "glad-all-over", "glass-onion", "golden-slumbers", "good-day-sunshine", "good-morning-good-morning", "good-night", "goodbye", "got-to-get-you-into-my-life", "hallelujah-i-love-her-so", "happiness-is-a-warm-gun", "hello-little-girl", "hello-goodbye", "help", "helter-skelter", "her-majesty", "here-comes-the-sun", "here-there-and-everywhere", "hey-bulldog", "hey-jude", "the-hippy-hippy-shake", "hold-me-tight", "honey-dont", "honey-pie", "the-honeymoon-song", "how-do-you-do-it", "i-am-the-walrus", "i-call-your-name", "i-dont-want-to-spoil-the-party", "i-feel-fine", "i-forgot-to-remember-to-forget", "i-got-a-woman", "i-got-to-find-my-baby", "i-just-dont-understand", "i-me-mine", "i-need-you", "i-saw-her-standing-there", "i-should-have-known-better", "i-wanna-be-your-man", "i-want-to-hold-your-hand", "i-want-to-tell-you", "i-want-you-shes-so-heavy", "i-will", "ill-be-back", "ill-be-on-my-way", "ill-cry-instead", "ill-follow-the-sun", "ill-get-you", "im-a-loser", "im-down", "im-gonna-sit-right-down-and-cry-over-you", "im-happy-just-to-dance-with-you", "im-in-love", "im-looking-through-you", "im-only-sleeping", "im-so-tired", "im-talking-about-you", "ive-got-a-feeling", "ive-just-seen-a-face", "if-i-fell", "if-i-needed-someone", "if-youve-got-trouble", "in-my-life", "in-spite-of-all-the-danger", "the-inner-light", "it-wont-be-long", "its-only-love", "johnny-b-goode", "julia", "junk", "kansas-city-hey-hey-hey-hey", "keep-your-hands-off-my-baby", "komm-gib-mir-deine-hand", "lady-madonna", "leave-my-kitten-alone", "lend-me-your-comb", "let-it-be", "like-dreamers-do", "little-child", "lonesome-tears-in-my-eyes", "the-long-and-winding-road", "long-tall-sally", "long-long-long", "los-paranoias", "love-me-do", "love-of-the-loved", "love-you-to", "lovely-rita", "lucille", "maggie-mae", "magical-mystery-tour", "mailman-bring-me-no-more-blues", "march-of-the-meanies", "martha-my-dear", "matchbox", "maxwells-silver-hammer", "mean-mr-mustard", "memphis-tennessee", "michelle", "misery", "money-thats-what-i-want", "moonlight-bay", "mother-natures-son", "mr-moonlight", "my-bonnie", "the-night-before", "no-reply", "nobodys-child", "norwegian-wood-this-bird-has-flown", "not-a-second-time", "not-guilty", "nothin-shakin", "now-and-then", "nowhere-man", "ob-la-di-ob-la-da", "octopuss-garden", "oh-darling", "old-brown-shoe", "one-after-909", "only-a-northern-song", "ooh-my-soul", "paperback-writer", "penny-lane", "pepperland", "pepperland-laid-waste", "piggies", "please-mister-postman", "please-please-me", "polythene-pam", "ps-i-love-you", "rain", "real-love", "revolution", "revolution-1", "revolution-9", "rip-it-up-shake-rattle-and-roll-blue-suede-shoes", "rock-and-roll-music", "rocky-raccoon", "roll-over-beethoven", "run-for-your-life", "savoy-truffle", "sea-of-holes", "sea-of-monsters", "sea-of-time", "searchin", "september-in-the-rain", "sexy-sadie", "sgt-peppers-lonely-hearts-club-band", "sgt-peppers-lonely-hearts-club-band-reprise", "she-came-in-through-the-bathroom-window", "she-loves-you", "she-said-she-said", "the-sheik-of-araby", "shes-a-woman", "shes-leaving-home", "shout", "sie-liebt-dich", "slow-down", "so-how-come-no-one-loves-me", "soldier-of-love", "some-other-guy", "something", "sour-milk-sea", "st-louis-blues", "step-inside-love", "strawberry-fields-forever", "sun-king", "sure-to-fall-in-love-with-you", "swanee-river", "sweet-little-sixteen", "take-good-care-of-my-baby", "take-out-some-insurance-on-me-baby", "taxman", "teddy-boy", "tell-me-what-you-see", "tell-me-why", "thank-you-girl", "that-means-a-lot", "thatll-be-the-day", "thats-all-right-mama", "the-ballad-of-john-and-yoko", "the-continuing-story-of-bungalow-bill", "the-end", "the-fool-on-the-hill", "the-hippy-hippy-shake", "the-honeymoon-song", "the-inner-light", "the-long-and-winding-road", "the-night-before", "the-saints", "the-sheik-of-araby", "the-word", "theres-a-place", "things-we-said-today", "think-for-yourself", "this-boy", "three-cool-cats", "ticket-to-ride", "till-there-was-you", "to-know-her-is-to-love-her", "tomorrow-never-knows", "too-much-monkey-business", "twist-and-shout", "two-of-us", "wait", "we-can-work-it-out", "what-goes-on", "what-youre-doing", "whats-the-new-mary-jane", "when-i-get-home", "when-im-sixty-four", "while-my-guitar-gently-weeps", "why", "why-dont-we-do-it-in-the-road", "wild-honey-pie", "with-a-little-help-from-my-friends", "within-you-without-you", "the-word", "words-of-love", "yellow-submarine", "yellow-submarine-in-pepperland", "yer-blues", "yes-it-is", "yesterday", "you-cant-do-that", "you-know-my-name-look-up-the-number", "you-know-what-to-do", "you-like-me-too-much", "you-never-give-me-your-money", "you-really-got-a-hold-on-me", "you-wont-see-me", "youll-be-mine", "youre-going-to-lose-that-girl", "youre-so-square-baby-i-dont-care", "youve-got-to-hide-your-love-away", "young-blood", "your-mother-should-know"] 
    #     request = RestClient.get('https://www.beatlesbible.com/songs/')
    #     html = Nokogiri::HTML(request)
    #    song_box = html.at(".post-7")
    #    song_titles = song_box.children.children.children.children
    #     song_titles_2 = song_titles.to_s().split('<li><a')
    #     song_titles_3 = song_titles_2.filter do |song_title| 
    #     song_title.include?('/songs/')
    #     end
    #     song_titles_4 = []
    #     song_titles_3.each do |song_title|
    #             song_titles_4 << song_title.split('/')[2]
    #     end
    #     song_titles_4.shift()
    #     print beatles_songs[0]
    #     beatles_songs.each do |song_name|
    #         print song_name
    #         print song_titles_4.song_name
    #    song_name = Medium.create(name: `#{song_name}`, author: 'The Beatles', category_id: 1, url: `https://genius.com/The-beatles-#{song_name}-lyrics`)
    #     end
    # end


    # def get_song_by_song
    #     matching_words = []
    #         songs_without_nonsense = []
    #         songs = Medium.get_songs
    #         songs.each do |song|
    #         song.each_line do |line|
    #                 songs_without_nonsense.push(line)
    #             end
    #             hit_open = false
    #             hit_close = false
    # end

end
