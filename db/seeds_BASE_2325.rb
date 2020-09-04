c = Category.create(name: 'Book')
m = Medium.create(name: 'The Book', author: 'John Doe', category_id: 1, url: 'https://www.gutenberg.org/files/1342/1342-h/1342-h.htm')
puts "seeded"