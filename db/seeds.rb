# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Like.delete_all
Review.delete_all
Idea.delete_all
User.delete_all

20.times.each do
    User.create(
        first_name: Faker::Superhero.name,
        last_name: Faker::GreekPhilosophers.name,
        email: Faker::TvShows::SiliconValley.email,
        password: 'password'
    )
end
users = User.all

10.times.each do
    i = Idea.create(
        title: Faker::TvShows::SiliconValley.invention,
        description: Faker::Quote.yoda,
        user: users.sample
    )
    if i.valid?
        i.reviews = rand(0..5).times.map do
            Review.create(
                body: Faker::TvShows::MichaelScott.quote,
                idea: i,
                user: users.sample
            )
        end

        rand(0..20).times.map do
            Like.create(
                user: users.sample,
                idea: i
            )
        end
    end
end

p "generated #{Idea.all.count} ideas"
p "generated #{Review.all.count} reviews"
p "generated #{users.count} users"
p "generated #{Like.count} likes"
