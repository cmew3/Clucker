env=ENV["RACK_ENV"] || "development"
DataMapper.setup(:default, "postgres://localhost/clucker_#{env}")
DataMapper.finalize
