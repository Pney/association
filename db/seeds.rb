# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

Debt.destroy_all
Person.destroy_all
User.destroy_all

puts "Data/Hora Inicio: #{Time.now}"

50.times do
    user = User.create!(
        email: Faker::Internet.email,
        password: Faker::Internet.password(min_length: 8, special_characters: true)
    )
    puts user.inspect
end

users_ids = User.all.ids

100.times do
    person = Person.create!(
        name: Faker::Name.name,
        phone_number: Faker::PhoneNumber.cell_phone_in_e164,
        national_id: CPF.generate,
        active: Faker::Boolean.boolean,
        user_id: users_ids.sample
    )
    puts person.inspect
end

persons_ids = Person.all.ids

500.times do
    debt = Debt.create!(
        person_id: persons_ids.sample,
        amount: Faker::Number.positive,
        observation: Faker::Quote.famous_last_words
    )

    puts debt.inspect
end

puts "Data/Hora Fim: #{Time.now}"

user_example = User.find(User.pluck(:id).sample)
puts "Usuário Criado:"
puts "login #{user_example.email}"
# puts "senha #{user_example.password}"
