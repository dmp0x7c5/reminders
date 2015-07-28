FactoryGirl.define do
  factory :user do
    provider nil
    uid nil
    name "John Doe"

    factory :admin do
      admin true
      uid 1234
      provider "google_oauth2"
    end
  end
end
