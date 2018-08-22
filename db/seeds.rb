User.destroy_all
Employee.destroy_all

company = User.create!(
  email: 'company@company.com',
  password: '123456',
  company_name: 'Company Inc',
  address: 'Av Visconde de Piraja 495, Rio De Janiero'
  )

10.times do |i|
  e = Employee.create!(
    name: "employee #{i}",
    address: "Av Visconde de Piraja #{rand(100..900)}, Rio De Janiero",
    user: company
    )
end
