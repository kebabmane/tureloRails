class Ahoy::Store < Ahoy::Stores::ActiveRecordStore
  Ahoy.geocode = :async
end
