# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

user = User.new(:email=>"duff.john@gmail.com", :login=>'jduff', :password=>"jduff")
user.save!(:validate => false)

user.tasks.create!(:name => "Take out the trash")
user.tasks.create!(:name => "Do something awesome")
