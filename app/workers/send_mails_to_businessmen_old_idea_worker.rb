class SendMailsToBusinessmenOldIdeaWorker
  include Sidekiq::Worker

  def perform
    ideas = Idea.notification_period
    ideas.each do |idea|
      BusinessmanMailer.with(idea: idea).old_idea.deliver_later
    end
  end
end
