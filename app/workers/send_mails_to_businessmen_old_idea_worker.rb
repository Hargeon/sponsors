class SendMailsToBusinessmenOldIdeaWorker
  include Sidekiq::Worker

  def perform
    ideas = Idea.where('active_time < ? AND active = ?', 20.day.ago, true)
    ideas.each do |idea|
      BusinessmanMailer.with(idea: idea).old_idea.deliver_later
    end
  end
end
