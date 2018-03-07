# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

snerds = Family.find_or_create_by(name: 'Snerds')
ray    = snerds.users.find_by(email: 'ray.bradley@gmail.com')
if ray.nil?
  snerds.users.create(
    email: 'ray.bradley@gmail.com',
    password: 'b0ng0d0G',
    password_confirmation: 'b0ng0d0G'
  )
end
snerds.accounts.find_or_create_by(name: 'Wells Fargo')
