class ApiLog
  include Mongoid::Document
  include Mongoid::Timestamps

  field :endpoint, type: String
  field :request_method, type: String
  field :params, type: Hash
  field :response_code, type: Integer
end
