puts 'Initializing Seeding...'

request = RestClient.get('https://www.beatlesbible.com/songs/')
html = Nokogiri.HTML(request)
song_box = html.at('.post-7')
song_titles = song_box.children.children.children.children
song_titles_2 = song_titles.to_s.split('<li><a')
song_titles_3 =
  song_titles_2.filter { |song_title| song_title.include?('/songs/') }
song_titles_4 = []
song_titles_3.each { |song_title| song_titles_4 << song_title.split('/')[2] }
song_titles_4.shift
song_titles_4.shift
c = Category.create(name: 'Music')

song_titles_4.each do |song_name|
  Medium.create(
    name: song_name,
    author: 'The Beatles',
    category: c,
    url: "https://genius.com/The-beatles-#{song_name}-lyrics"
  )
end

puts 'Seeding Complete'
