FactoryBot.define do
  factory :application, class: Doorkeeper::Application do
    uid { "00000000001" }
    name { "application_01" }
    secret { "application_secret_01" }
    redirect_uri { "http://localhost:3000/test/mockup_callback" }
  end
end
