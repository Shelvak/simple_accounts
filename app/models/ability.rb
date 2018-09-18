class Ability
  include CanCan::Ability

  def initialize(user)
    user ? user_rules(user) : default_rules
  end

  def user_rules(user)
    user.roles.each do |role|
      send("#{role}_rules") if respond_to?("#{role}_rules")
    end
  end

  def admin_rules
    can :manage, :all
    can :assign_roles, User
    can :edit_profile, User
    can :update_profile, User
  end

  def regular_rules
    can :read, :all
    can :create, :all
    can :update, :all
    can :edit_profile, User
    can :update_profile, User
    cannot [:read, :create, :update], User
  end
end
