# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, User
    can :read, Idea do |idea|
      idea.active == true
    end

    if user.businessman?
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
