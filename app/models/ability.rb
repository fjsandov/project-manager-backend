# frozen_string_literal: true

# See the wiki for details:
# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, to: :crud
    can :create, User
    can %i(read update), User, user_id: user.id
    can :crud, Project, user_id: user.id
    can :crud, Task, project: { user_id: user.id }
  end
end
