# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do


  allow do
    origins '*'
    resource '/api/work_times', headers: :any, methods: [:get, :post]
    resource '/api/sync_work_time', headers: :any, methods: [:post]
    resource '/api/sync_work_times', headers: :any, methods: [:post]

  end
end
