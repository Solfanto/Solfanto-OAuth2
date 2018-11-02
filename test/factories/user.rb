# This will guess the User class
FactoryBot.define do
  factory :user do
    email { "johndoe@solfanto.com" }
    password { "aaaaaa" }
    admin { false }
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: "User" do
    email { "admin@solfanto.com" }
    password { "bbbbbb" }
    admin { true }
  end
end
