class Task < ActiveRecord::Base
  STATUS = ["complete", "in progress"]
  belongs_to :creator, :class_name=>'User', :foreign_key => "creator_id"

  validates_presence_of :creator, :name
  validates_inclusion_of :status, :in => STATUS, :allow_nil=>true
  acts_as_taggable

  attr_accessible :name, :tag_list

  scope :status, Proc.new { |s| where(:status=>s) }
  scope :current, Proc.new {
    where(Task[:status].not_eq('complete').or(Task[:status].eq(nil)))
  }

  # define status helper methods such as complete? and in_progress?
  STATUS.each do |status|
    define_method "#{status.split.join('_')}?" do
      self.status == status
    end
  end
end
