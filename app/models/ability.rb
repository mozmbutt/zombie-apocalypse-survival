# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here.
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, Item
    elsif user.survivor?
      can :create, Infection, reporter_id: user.id
      can :manage, Location, user_id: user.id
      can :manage, Inventory, user_id: user.id
      can :manage, Trade
      can :manage, TradeHistory, user_id: user.id
    end
  end
end
