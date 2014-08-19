env=ENV["RACK_ENV"] || "development"
DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/clucker_#{env}")
DataMapper.finalize
