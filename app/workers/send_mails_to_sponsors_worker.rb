class SendMailsToSponsorsWorker
  include Sidekiq::Worker

  def perform(idea_id)
    idea = Idea.find(idea_id)
    emails = SponsorsQueries.new(idea).idea_will_like_sponsors.pluck(:email)
    emails.each do |email|
      SponsorMailer.with(idea: idea, email: email).new_idea.deliver_later
    end
  end
end
