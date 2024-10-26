class Ability
  include CanCan::Ability

 
   def initialize(user)
    if user.manager?
      can :manage, Project, user_id: user.id  
      can :read, Project
      can :manage, Bug
      
      can :add_users, Project
    elsif user.developer?
      can :read, Project, users: { id: user.id }  
    can :read, Bug 
      can :update, Bug, developer_id: user.id
      cannot :edit, Bug
     
      
    elsif user.qa?
      cannot :create, Project
      can :read, Project  
      can :create, Bug  
      can :manage, Bug
    end
  end
end
