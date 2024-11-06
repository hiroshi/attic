Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # origins '*'
    origins do |source, env|
      # p env
      # p source
      # p env['HTTP_AUTHORIZATION']
      true
    end
    resource '*', headers: :any, methods: [:get, :post, :patch, :put], credentials: true
  end
end
