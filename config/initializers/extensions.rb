module ActiveRecordExtensions
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def [](val)
      arel_table[val]
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecordExtensions)
