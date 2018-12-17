namespace :recommendable do
  desc "Load books"
  task load_samples: :environment do
    csv = CSV.read('books.csv', headers: true).first(500)
    csv.map { |line| line['authors'] }.uniq.each { |author| Author.create(name: author) }

    csv.each do |book|
      book = Book.create(title: book['title'], description: FFaker::Book.description, release_year: book['original_publication_year'].to_i.to_s,
                         author: Author.find_by_name(book['authors']), genre: Genre.find_or_create_by(name: FFaker::Book.genre), image_url: book['image_url'])
    end
  end

  desc "Load User reviews"
  task load_users: :environment do
    500.times do
      User.create(email: FFaker::Internet.email, password: FFaker::Internet.password, name: FFaker::Internet.user_name,
                  age: rand(18..60), country: FFaker::Address.country, gender: FFaker::Gender.random)
    end

    books = Book.all
    User.all.find_each do |user|
      puts "Generate reviews for User##{user.id}"
      liked_books = books.sample(150)
      disliked_books = [books - liked_books].sample(150)
      reviewed_books = books.sample(3)
      liked_books.each { |book| user.like(book) }
      disliked_books.each { |book| user.dislike(book) }
      reviewed_books.each { |book| Review.create(user: user, book: book, content: FFaker::Lorem.paragraph)}
    end

  end

  desc 'Unrate some books'
  task unrate_books: :environment do
    books = Book.all
    User.all.find_each do |user|
      puts "Unrate for User##{user.id}"
      books.sample(150).each do |book|
        user.unlike(book)
        user.undislike(book)
      end
    end
  end


end
