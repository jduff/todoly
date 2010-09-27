# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.sequence(:email)      {|n| "user#{n}@example.com" }
  f.sequence(:login)      {|n| "user#{n}" }
  f.password              "password"
  f.password_confirmation "password"
end
