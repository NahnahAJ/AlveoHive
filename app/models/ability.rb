# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:

    user ||= User.new # guest user (not logged in)
    
    can :read, Property
    can :read, Article

    if user.admin? || user.persisted?
      can :manage, :all
    else
      can :manage, User, id: user.id
      can :manage, UserDetail, user_id: user.id
      can :manage, Social, user_id: user.id
      can :manage, Property, user_id: user.id
      can :manage, Article, user_id: user.id
      can :manage, Enquiry, user_id: user.id
    end
  end
end
