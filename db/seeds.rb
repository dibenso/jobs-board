# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

company = Company.create(name: 'dibens.io', url: 'http://dibens.io')
company.save
employer = Employer.create(email: 'dillon.benson93@gmail.com', password: '<abc123>', username: 'dillon.benson93')
employer.company = company
employer.save
user = User.create(email: 'dillboy928@gmail.com', password: '<abc123>', username: 'dillboy928')
user.save
job = Job.create(name: 'Ruby Developer', min_wage: 70_000.00, max_wage: 90_000.00, time: 'Full', location: 'New York, NY', description: 'Help expand and maintain our wonderful cloud platform using your Ruby and Rails expertise.', job_category: 'Web Developer')
job.company = company
job.save
job2 = Job.create(name: 'Front End Developer', min_wage: 50_000.00, max_wage: 60_000.00, time: 'Full', location: 'New York, NY', description: 'Help expand and maintain the front end of our amazing cloud platform using your HTML, CSS, and javascripts skills', job_category: 'Web Developer')
job2.company = company
job2.save

employer.jobs << job
employer.jobs << job2
