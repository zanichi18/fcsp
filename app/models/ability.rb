class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case user.role
    when "admin"
      can :manage, Company
      can :manage, User
    else
      can :read, Company
    end
  end
end
