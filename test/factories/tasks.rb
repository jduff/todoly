# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :task do |f|
  f.sequence(:name) {|n| "Task #{n}"}

  f.association :creator, :factory=>:user
end
