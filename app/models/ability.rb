# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, User
    can :read, Idea do |idea|
      idea.active == true
    end

    can :search, Idea
    can :filter, Idea

    if user.businessman?
      can :read, Idea do |idea|
        (idea.user == user) && (idea.active == false)
      end

      can :read, Interest do |interest|
        user.ideas.find(interest.idea_id).present?
      end

      can :create, Idea

      can :update, Idea do |idea|
        idea.user == user
      end

      can :destroy, Idea do |idea|
        idea.user == user
      end

      can :update_active_time, Idea do |idea|
        (idea.user == user) && idea.update_active_period?
      end

    elsif user.sponsor?
      can :read, Interest do |interest|
        interest.user == user
      end

      can :create, Interest
      can :create, Like

      can :destroy, Like do |like|
        like.user == user
      end

      can :create, Dislike

      can :destroy, Dislike do |dislike|
        dislike.user == user
      end

      can :create, Rating
    end

    can :update, User, id: user.id
  end
end
