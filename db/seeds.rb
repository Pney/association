# rubocop:disable Layout:FirstHashElementIndentation)
require 'faker'

# Destroy data:
# Debt.destroy_all
# Person.destroy_all
# User.destroy_all
# Payment.destroy_all

user_qty = 300
person_qty = 1000
debt_qty = 1000
payment_qty = 1000

attributes_default = {
	email: 'admin@admin.com',
	password: 'admin123'
}
user_default = User.where(email: attributes_default[:email]).first_or_create(attributes_default)

puts "Usuário default criado com sucesso! \n #{user_default.inspect}"
puts "Data/Hora Inicio: #{Time.now}"

user_qty.times do |i|
	attributes = {
		email: Faker::Internet.email,
		password: Faker::Internet.password(min_length: 8, special_characters: true)
	}

	User.create!(attributes)
	puts "User - #{i}/#{user_qty} created!"
end

users_ids = User.all.ids

person_qty.times do |i|
	attributes = {
		name: Faker::Name.name,
		phone_number: Faker::PhoneNumber.cell_phone_in_e164,
		national_id: CPF.generate,
		active: Faker::Boolean.boolean,
		user_id: users_ids.sample
	}

	Person.create!(attributes)
	puts "Peoples - #{i}/#{person_qty} created!"
end

peoples_ids = Person.all.ids

debt_qty.times do |i|
	attributes = {
		person_id: peoples_ids.sample,
		amount: Faker::Number.positive,
		observation: Faker::Quote.famous_last_words
	}

	Debt.create!(attributes)
	puts "Debts - #{i}/#{debt_qty} created!"
end

payment_qty.times do |i|
	attributes = {
		person_id: peoples_ids.sample,
		amount: Faker::Number.positive,
		paid_at: Faker::Date.between(from: 1.year.ago, to: Date.today)
	}

	Payment.create!(attributes)
	puts "Payment - #{i}/#{payment_qty} created!"
end

puts "Data/Hora Fim: #{Time.now}"