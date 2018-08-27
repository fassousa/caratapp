company = User.create!(
  email: 'abc@email.com',
  password: '123123',
  company_name: 'ABC Inc',
  address: 'Av Visconde de Piraja 495, Rio De Janiero'
  )

10.times do |i|
  e = Employee.create!(
    name: "employee #{i}",
    address: "Av Visconde de Piraja #{rand(100..900)}, Rio De Janiero",
    user: company
    )
end
