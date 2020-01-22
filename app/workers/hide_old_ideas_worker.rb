class HideOldIdeasWorker
  include Sidekiq::Worker

  def perform
    ideas = Idea.where('active_time < ? AND active = ?', 30.day.ago, true)
    ideas.update_all(active: false)
  end
end
