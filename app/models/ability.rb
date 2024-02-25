# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin? || user.persisted?
      can :manage, :all
    else
      can :read, :all
      can :create, Property
      can :create, Article
      can :create, UserDetail
      can :create, Category
      can :create, Social
      can :create, Enquiry
      can :create, Amenity
      can :create, Currency


      can [:update, :destroy], Property, user_id: user.id
      can [:update, :destroy], Article, user_id: user.id
      can [:update, :destroy], UserDetail, user_id: user.id
      can [:update, :destroy], Category
      can [:update, :destroy], Social, user_id: user.id
      can [:update, :destroy], Enquiry, user_id: user.id
      can [:update, :destroy], Amenity, user_id: user.id
      can [:update, :destroy], Currency, user_id: user.id
    end
  end
end