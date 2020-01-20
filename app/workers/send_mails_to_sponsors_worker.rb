class SendMailsToSponsorsWorker
  include Sidekiq::Worker

  def perform(idea_id)
    idea = Idea.find(idea_id)
    emails = User.sponsors.pluck(:email)
    emails.each do |email|
      SponsorMailer.with(idea: idea, email: email).new_idea.deliver_later
    end
  end
end
