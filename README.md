# Jobs board

## screenshots
![](https://raw.githubusercontent.com/dibenso/jobs-board/master/screenshots/screenshot1.png)   

![](https://raw.githubusercontent.com/dibenso/jobs-board/master/screenshots/screenshot2.png)   

## routes
**GET /** -- The root path that displays different kinds of jobs.   
**POST /jobs** -- If an employer is signed in and belongs to a company, they can create new jobs.   
**GET /jobs/new** -- If an employer is signed in and belongs to a company, this page displays the form to create a new job.   
**GET /jobs/:id/edit** -- Displays form to edit a job.   
**GET /jobs/:id** -- Displays the contents of a job   
**PUT /job/:id** -- Updates a job.   
**DELETE /job/:id** -- Destroys a job.   
**GET /job_applications** -- If a user is signed in, this page shows all of the applications sent out by that user. If an employer is signed in, this page shows all of the applications received by the jobs they created.   
**GET /job_applications/:id** -- Show a job application.   
**DELETE /job_application/:id** -- deletes a job if an employer is signed in.   
**POST /jobs_application/:job_id/create** -- If a user is signed in this will create a new job application for a job.   
**GET /employers** -- Show all jobs created by an employer if they are signed in.   
**POST /employers/join_company** -- If an employer is signed in and they don't already belong to a company, this will allow them to join a company using a secret key.   
**POST /employers/add_company** -- If an employer is signed in and they don't already belong to a company, this will allow them to create a new company.   
**GET /users** -- Shows all jobs that a user applied to if they are signed in.   
**GET /companies** -- Shows different kinds of companies.   
**GET /companies/:id/jobs** -- Shows all jobs that company has.   
**GET /companies/:id** -- Shows information about a company.   
**POST /companies/:company_id/reviews** -- Creates a review for a company if a user is signed in.   
**GET /reviews/:id/edit** -- Displays a form for a user to edit their reviews if they are signed in.   
**PUT /reviews/:id** -- If a user is signed in, this will update their reviews.   
**DELETE /reviews/:id** -- If a user is signed in, this will destroy their reviews.   
**GET /reviews** -- If a user is signed in, this page displays all of their reviews.   