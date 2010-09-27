class Task < ActiveRecord::Base
  belongs_to :creator, :class_name=>'User', :foreign_key => "creator_id"

  validates_presence_of :creator, :name
  acts_as_taggable
end
