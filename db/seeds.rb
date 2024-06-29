# rubocop:disable Layout:FirstHashElementIndentation)
require 'faker'

# Destroy data:
# Debt.destroy_all
# Person.destroy_all
# User.destroy_all
# Payment.destroy_all

# Se caso der erro para rodar as seeds, rode o projeto com bin/dev e rode rails db:seed em outro terminal
user_qty = 150
person_qty = 100000
debt_qty = 100000
payment_qty = 100000

# attributes_default = {
# 	email: 'admin@admin.com',
# 	password: 'admin123'
# }
# user_default = User.where(email: attributes_default[:email]).first_or_create(attributes_default)
# puts "Usuário default criado com sucesso! \n #{user_default.inspect}"

# USERS
puts "Data/Hora Inicio User: #{Time.now}"
users = []
user_qty.times do |i|
	attributes = {
		email: Faker::Internet.email,
		password: Faker::Internet.password(min_length: 8, special_characters: true)
	}
	User.create(attributes)
	puts "Users - #{i} attribuited! | #{Time.now}"
end
puts "Data/Hora Fim User #{Time.now}"


# PEOPLES
puts "Data/Hora Peoples Inicio: #{Time.now}"
users_ids = User.all.ids
persons = []
person_qty.times do |i|
	attributes = {
		name: Faker::Name.name,
		phone_number: Faker::PhoneNumber.cell_phone_in_e164,
		national_id: CPF.generate,
		active: Faker::Boolean.boolean,
		user_id: users_ids.sample
	}
	persons << attributes
end
Person.upsert_all(persons)
puts "Peoples - #{persons.count} attribuited! | #{Time.now}"

# DEBTS
puts "Data/Hora Debts Inicio: #{Time.now}"
peoples_ids = Person.all.ids
debts = []
debt_qty.times do |i|
	attributes = {
		person_id: peoples_ids.sample,
		amount: rand(80000.0..1800000.0),
		observation: Faker::Quote.famous_last_words
	}
	debts << attributes
end
Debt.upsert_all(debts)
puts "Debts - #{debts.count} attribuited! | #{Time.now}"

# PAYMENTS
puts "Data/Hora Payments Inicio: #{Time.now}"
payments = []
payment_qty.times do |i|
	attributes = {
		person_id: peoples_ids.sample,
		amount: Faker::Number.positive,
		paid_at: Faker::Date.between(from: 1.year.ago, to: Date.today)
	}
	payments << attributes
end
Payment.upsert_all(payments)
puts "Payments - #{payments.count} attribuited! | #{Time.now}"

puts "All Inserts | Data/Hora Fim: #{Time.now}"