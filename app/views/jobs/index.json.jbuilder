json.array!(@jobs) do |job|
  json.extract! job, :id, :name, :min_wage, :max_wage, :time, :location
  json.url job_url(job, format: :json)
end
