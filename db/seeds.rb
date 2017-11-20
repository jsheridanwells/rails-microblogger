99.times do |num|
  name = Faker::Name.unique.first_name
  email = "#{name}@example.com"
  password = '123456'

  User.create!(
      name: name,
      email: email,
      password: password,
      password_confirmation: password
    )
end
