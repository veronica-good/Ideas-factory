# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Idea.delete_all
User.delete_all

PASSWORD='supersecret'
super_user= User.create(
    first_name: 'John',
    last_name:'Snow',
    email: 'js@winterfell.gov',
    password: PASSWORD,
    # is_admin: true
)
12.times do
    User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email, 
        password: PASSWORD
    )
end
u=User.all

50.times do
    created_at=Faker::Date.backward(days: 365)
    j=Idea.create(
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph_by_chars,
        created_at: created_at,
        updated_at: created_at,
        user: u.sample
    )
    if j.valid?
        j.reviews=rand(0..15).times.map do
            created_at=Faker::Date.backward(days: 36)
            Review.new(
                body: Faker::GreekPhilosophers.quote,
                user: u.sample, 
                created_at: created_at,
                updated_at: created_at
            )
        end
    end
end

i=Idea.all
r=Review.all
puts "Created #{i.count} ideas, #{u.count} users, #{r.count} reviews"