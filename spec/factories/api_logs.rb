FactoryBot.define do
  factory :api_log do
    endpoint { "/notes" }
    request_method { "GET" }
  end
end
