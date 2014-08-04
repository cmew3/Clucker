class Cluck

	include DataMapper::Resource

	property :id, Serial
	property :text, String, :length => 0..140
	property :time, Time, :default => Time.now
	property :mood, String, :default => "neutral"
	has n, :tags, :through => Resource
	has n, :users, :through => Resource
	# belongs_to :user

end	