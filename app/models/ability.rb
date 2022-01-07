# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here.
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, Item
    elsif user.survivor?
      can :create, Infection
      can :manage, Location
      can :manage, Inventory
      can :manage, Trade
      can :manage, TradeHistory
    end
  end
end
