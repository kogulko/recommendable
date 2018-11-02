# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
#
50.times { Author.create(name: FFaker::Book.title )}
15.times { Genre.create(name: FFaker::Book.genre )}

300.times { Book.create(title: FFaker::Book.title, description: FFaker::Book.description,
                        author: Author.all.sample, genre: Genre.all.sample, image_url: FFaker::Book.cover)}
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?