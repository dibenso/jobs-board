json.array!(@job_applications) do |job_application|
  json.extract! job_application, :id, :job_id, :user_id, :employer_id, :first_name, :last_name, :cover_letter
  json.url job_application_url(job_application, format: :json)
end
