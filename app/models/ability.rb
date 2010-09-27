class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # in case of guest

    # can :manage, Something, :user_id => user.id
    can :read, :all
  end
end