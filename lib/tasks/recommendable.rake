namespace :recommendable do
  desc "TODO"
  task load_samples: :environment do
    csv = CSV.read('books.csv', headers: true).first(500)
    csv.map { |line| line['authors'] }.uniq.each { |author| Author.create(name: author) }
    csv.each do |book|
      Book.create(title: book['title'], description: FFaker::Book.description, release_year: book['original_publication_year'].to_i.to_s,
                  author: Author.find_by_name(book['authors']), genre: Genre.all.sample, image_url: book['image_url'])
    end
    end
end
