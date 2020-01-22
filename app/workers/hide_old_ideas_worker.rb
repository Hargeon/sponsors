class HideOldIdeasWorker
  include Sidekiq::Worker

  def perform
    ideas = Idea.active_period
    ideas.update_all(active: false)
  end
end
