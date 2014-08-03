class Tag

	include DataMapper::Resource

	property :id, Serial
	property :text, String, :unique => true

	has n, :clucks, :through => Resource
end