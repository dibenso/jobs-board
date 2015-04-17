# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

employer = Employer.create(email: 'dillon.benson93@gmail.com', password: '<abc123>', username: 'dillon.benson93')
employer.save
user = User.create(email: 'dillboy928@gmail.com', password: '<abc123>', username: 'dillboy928')
user.save
job = Job.create(name: 'Ruby Developer', min_wage: 70_000.00, max_wage: 90_000.00, time: 'Full', location: 'New York, NY', description: 'Help expand and maintain our wonderful cloud platform using your Ruby and Rails expertise.', company: 'dibensio.io')
job.save

employer.jobs << job
user.jobs << job
