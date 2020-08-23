c = Category.create(name: 'book')
m = Medium.create(name: 'book', author: 'John Doe', category_id: 1)
Phrase.create(text: 'https://www.gutenberg.org/files/1342/1342-h/1342-h.htm', medium_id: 1)
puts "seeded"